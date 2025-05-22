#!/bin/bash

echo "[INFO] Avvio di XLink Kai..."
/opt/xlinkkai/kaiEngine -d &

KAI_PID=$!
echo $KAI_PID > /tmp/kai.pid

echo "[INFO] Avvio interfaccia web su porta 8099..."
cat << 'EOF' > /tmp/webserver.py
import http.server, socketserver, os, subprocess

PORT = 8099

class KaiHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/kai-status':
            try:
                with open("/tmp/kai.pid", "r") as f:
                    pid = int(f.read())
                os.kill(pid, 0)
                self.send_response(200)
                self.end_headers()
                self.wfile.write(b"In esecuzione")
            except:
                self.send_response(200)
                self.end_headers()
                self.wfile.write(b"Non attivo")
        elif self.path == '/kai-log':
            log = subprocess.getoutput("tail -n 40 /opt/xlinkkai/kaiEngine.log")
            self.send_response(200)
            self.end_headers()
            self.wfile.write(log.encode())
        else:
            return http.server.SimpleHTTPRequestHandler.do_GET(self)

os.chdir("/web")
with socketserver.TCPServer(("", PORT), KaiHandler) as httpd:
    print(f"[INFO] Web disponibile su porta {PORT}")
    httpd.serve_forever()
EOF

python3 /tmp/webserver.py
