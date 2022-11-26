From: Steffan Karger <steffan@...1856...>
Date: Sat, 26 Nov 2022 16:52:17 +0100
Message-Id: <20221126155216.25148-1-steffan@...1856...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC PATCH] Add connection test suite
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Add a local connection test suite, that is able to set up connections
and verify in the process output that the process believes the
connection was successful.

This is not a replacement for the t_client test suite, but rather a
fast, simple, local suite to validate .e.g control channel setup. It can
replace t_cltsrv.sh (as a much faster alternative), but does require
python3 and pytest to run.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
This is an RFC to get comments on whether you believe this approach is a
useful addition to our current test suite. We can add many more useful
tests once we agree on the approach.

 tests/Makefile.am                       |   6 +-
 tests/connection_tests/test_examples.py | 303 ++++++++++++++++++++++++
 tests/t_connection.sh                   |  24 ++
 3 files changed, 331 insertions(+), 2 deletions(-)
 create mode 100644 tests/connection_tests/test_examples.py
 create mode 100755 tests/t_connection.sh

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 89180f60..96b8565b 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -14,12 +14,14 @@ MAINTAINERCLEANFILES = \
 
 SUBDIRS = unit_tests
 
-test_scripts = t_client.sh t_lpback.sh t_cltsrv.sh
+test_scripts = t_client.sh t_lpback.sh t_cltsrv.sh t_connection.sh
 if HAVE_SITNL
 test_scripts += t_net.sh
 endif
 
-TESTS_ENVIRONMENT = top_srcdir="$(top_srcdir)"
+TESTS_ENVIRONMENT = \
+	top_builddir="$(top_builddir)" \
+	top_srcdir="$(top_srcdir)"
 TESTS = $(test_scripts)
 
 dist_noinst_SCRIPTS = \
diff --git a/tests/connection_tests/test_examples.py b/tests/connection_tests/test_examples.py
new file mode 100644
index 00000000..030fa21b
--- /dev/null
+++ b/tests/connection_tests/test_examples.py
@@ -0,0 +1,303 @@
+import os
+import pytest
+import re
+import subprocess
+import tempfile
+import threading
+import time
+
+from pathlib import Path
+
+OPENVPN = Path(os.environ["OPENVPN_BINARY"])
+CD_PATH = Path(os.environ["WORK_DIR"])
+
+
+class BasicOption:
+    def __init__(self, name, *args):
+        self.name = name
+        self.value = " ".join(args)
+
+    def toconfigfileitem(self):
+        return f"{self.name} {self.value}\n"
+
+
+class InlineOption(BasicOption):
+    def __init__(self, name, *args, infile=None):
+        self.name = name
+        if infile is not None:
+            path = Path(infile)
+            if not path.is_absolute():
+                path = CD_PATH / infile
+            self.value = open(path).read()
+        else:
+            self.value = " ".join(args)
+
+    def toconfigfileitem(self):
+        return f"<{self.name}>\n{self.value.strip()}\n</{self.name}>".strip()
+
+
+class OpenVPNConfig:
+    DEFAULT_CONFIG_BASE = [
+        BasicOption("dev", "null"),
+        BasicOption("local", "localhost"),
+        BasicOption("remote", "localhost"),
+        BasicOption("verb", "3"),
+        BasicOption("reneg-sec", "10"),
+        BasicOption("ping", "1"),
+        BasicOption("cd", str(CD_PATH)),
+        BasicOption("ca", "sample-keys/ca.crt"),
+    ]
+    DEFAULT_SERVER_PORT = "16010"
+    DEFAULT_CLIENT_PORT = "16011"
+
+    def __init__(self, name="OpenVPN", options=DEFAULT_CONFIG_BASE, extra_options=[]):
+        self.options = options + extra_options
+        self.name = name
+
+    def toconfigfile(self):
+        c = tempfile.NamedTemporaryFile(mode="w+")
+        for option in self.options:
+            c.write(option.toconfigfileitem() + "\n")
+            c.flush()
+        return c
+
+
+class ServerConfig(OpenVPNConfig):
+    DEFAULT_SERVER_OPTIONS = [
+        BasicOption("lport", OpenVPNConfig.DEFAULT_SERVER_PORT),
+        BasicOption("rport", OpenVPNConfig.DEFAULT_CLIENT_PORT),
+        BasicOption("tls-server"),
+        BasicOption("dh", "none"),
+        BasicOption("key", "sample-keys/server.key"),
+        BasicOption("cert", "sample-keys/server.crt"),
+    ]
+
+    def __init__(self, name="Server", extra_options=[]):
+        super().__init__(name=name, extra_options=self.DEFAULT_SERVER_OPTIONS)
+
+        self.options += extra_options
+
+
+class ClientConfig(OpenVPNConfig):
+    DEFAULT_SERVER_OPTIONS = [
+        BasicOption("lport", OpenVPNConfig.DEFAULT_CLIENT_PORT),
+        BasicOption("rport", OpenVPNConfig.DEFAULT_SERVER_PORT),
+        BasicOption("tls-client"),
+        BasicOption("remote-cert-tls", "server"),
+        BasicOption("key", "sample-keys/client.key"),
+        BasicOption("cert", "sample-keys/client.crt"),
+    ]
+
+    def __init__(self, name="Client", extra_options=[]):
+        super().__init__(name=name, extra_options=self.DEFAULT_SERVER_OPTIONS)
+
+        self.options += extra_options
+
+
+class RegexNotFound(Exception):
+    def __init__(self, pattern, string):
+        super().__init__(f'Regex "{pattern}" does not match "{string}"')
+
+
+class OpenVPNProcess:
+    def __init__(self, config, name=None):
+        self._configfile = config.toconfigfile()
+        self.name = name if name is not None else config.name
+        self.full_output = ""
+
+    def __enter__(self):
+        self._p = subprocess.Popen(
+            [OPENVPN, self._configfile.name], stdout=subprocess.PIPE, text=True
+        )
+
+        def append_stdout_to_string():
+            for line in self._p.stdout:
+                self.full_output += line
+
+        threading.Thread(target=append_stdout_to_string).start()
+
+        return self
+
+    def __exit__(self, type, value, traceback):
+        if self._p:
+            self._p.terminate()
+            self._p.wait(timeout=1)
+
+            print(f"{self.name} log:")
+            print(self.full_output)
+
+    @property
+    def returncode(self):
+        return self._p.returncode
+
+    def check_for_regex(self, pattern, flags=0):
+        if re.search(pattern, self.full_output, flags=flags) is None:
+            raise RegexNotFound(pattern, self.full_output)
+
+    def wait_for_regex(self, pattern, timeout=10, re_flags=0):
+        compiled_regex = re.compile(pattern, re_flags)
+        end_time = time.time() + timeout
+        while compiled_regex.search(self.full_output) is None:
+            if time.time() > end_time:
+                raise RegexNotFound(pattern, self.full_output)
+            time.sleep(0.1)
+
+
+def test_loopback_connection_udp():
+    """Basic UDP connection setup test"""
+    server = OpenVPNProcess(ServerConfig())
+    client = OpenVPNProcess(ClientConfig())
+
+    with server, client:
+        server.wait_for_regex("Initialization Sequence Completed")
+        client.wait_for_regex("Initialization Sequence Completed")
+
+    assert server.returncode == 0
+    assert client.returncode == 0
+
+
+def test_loopback_connection_tcp():
+    """Basic TCP connection setup test"""
+    server = OpenVPNProcess(
+        ServerConfig(extra_options=[BasicOption("proto", "tcp-server")])
+    )
+    client = OpenVPNProcess(
+        ClientConfig(extra_options=[BasicOption("proto", "tcp-client")])
+    )
+
+    with server, client:
+        server.wait_for_regex("Initialization Sequence Completed")
+        client.wait_for_regex("Initialization Sequence Completed")
+
+    assert server.returncode == 0
+    assert client.returncode == 0
+
+
+def test_loopback_connection_inline():
+    """Basic connection setup test with inline key/cert files"""
+    server = OpenVPNProcess(
+        ServerConfig(
+            extra_options=[
+                InlineOption("ca", infile="sample-keys/ca.crt"),
+                InlineOption("key", infile="sample-keys/server.key"),
+                InlineOption("cert", infile="sample-keys/server.crt"),
+            ]
+        )
+    )
+    client = OpenVPNProcess(
+        ClientConfig(
+            extra_options=[
+                InlineOption("ca", infile="sample-keys/ca.crt"),
+                InlineOption("key", infile="sample-keys/client.key"),
+                InlineOption("cert", infile="sample-keys/client.crt"),
+            ]
+        )
+    )
+
+    with server, client:
+        server.wait_for_regex("Initialization Sequence Completed")
+        client.wait_for_regex("Initialization Sequence Completed")
+
+    assert server.returncode == 0
+    assert client.returncode == 0
+
+
+def test_loopback_connection_tls_auth():
+    """Basic connection setup test with tls-auth enabled"""
+    server = OpenVPNProcess(
+        ServerConfig(extra_options=[BasicOption("tls-auth", "sample-keys/ta.key", "0")])
+    )
+    client = OpenVPNProcess(
+        ClientConfig(extra_options=[BasicOption("tls-auth", "sample-keys/ta.key", "1")])
+    )
+
+    with server, client:
+        server.wait_for_regex("Initialization Sequence Completed")
+        client.wait_for_regex("Initialization Sequence Completed")
+
+    server.check_for_regex(
+        "Outgoing Control Channel Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication"
+    )
+    server.check_for_regex(
+        "Incoming Control Channel Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication"
+    )
+    client.check_for_regex(
+        "Outgoing Control Channel Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication"
+    )
+    client.check_for_regex(
+        "Incoming Control Channel Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication"
+    )
+
+    assert server.returncode == 0
+    assert client.returncode == 0
+
+
+def test_loopback_connection_tls_crypt():
+    """Basic connection setup test with tls-crypt enabled"""
+    server = OpenVPNProcess(
+        ServerConfig(extra_options=[BasicOption("tls-crypt", "sample-keys/ta.key")])
+    )
+    client = OpenVPNProcess(
+        ClientConfig(extra_options=[BasicOption("tls-crypt", "sample-keys/ta.key")])
+    )
+
+    with server, client:
+        server.wait_for_regex("Initialization Sequence Completed")
+        client.wait_for_regex("Initialization Sequence Completed")
+
+    server.check_for_regex(
+        "Outgoing Control Channel Encryption: Cipher 'AES-256-CTR' initialized with 256 bit key"
+    )
+    server.check_for_regex(
+        "Incoming Control Channel Encryption: Using 256 bit message hash 'SHA256' for HMAC authentication"
+    )
+    client.check_for_regex(
+        "Outgoing Control Channel Encryption: Cipher 'AES-256-CTR' initialized with 256 bit key"
+    )
+    client.check_for_regex(
+        "Incoming Control Channel Encryption: Using 256 bit message hash 'SHA256' for HMAC authentication"
+    )
+
+    assert server.returncode == 0
+    assert client.returncode == 0
+
+
+def test_loopback_reneg():
+    """Test that OpenVPN successfully renegotiates"""
+    server = OpenVPNProcess(ServerConfig(extra_options=[BasicOption("reneg-sec", "5")]))
+    client = OpenVPNProcess(ClientConfig())
+
+    with server, client:
+        server.wait_for_regex("Initialization Sequence Completed")
+        client.wait_for_regex("Initialization Sequence Completed")
+
+        server.wait_for_regex(
+            "TLS: soft reset.*"
+            "Outgoing Data Channel: Cipher .* initialized.*"
+            "Incoming Data Channel: Cipher .* initialized",
+            re_flags=re.DOTALL,
+        )
+        # The server initiates the renegotiation, client don't log a clear
+        # entry that indicates renegotiation was started, so just check that
+        # the data channel was initialized at least twice.
+        client.wait_for_regex(
+            "Outgoing Data Channel: Cipher .* initialized.*"
+            "Outgoing Data Channel: Cipher .* initialized",
+            re_flags=re.DOTALL,
+        )
+
+    assert server.returncode == 0
+    assert client.returncode == 0
+
+
+@pytest.mark.xfail
+def test_connection_xfail():
+    """Example of a test that is marked as expected to fail
+
+    TODO For discussion purposes only, remove before final version
+    """
+    server = OpenVPNProcess(ServerConfig())
+    with server:
+        server.wait_for_regex("No can do sir", timeout=1)
+
+    assert server.returncode == 0
diff --git a/tests/t_connection.sh b/tests/t_connection.sh
new file mode 100755
index 00000000..846dd4e3
--- /dev/null
+++ b/tests/t_connection.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+set -eu
+
+# by changing this to 1 we can force automated builds to fail
+# that are expected to have all the prerequisites
+TCLIENT_SKIP_RC="${TCLIENT_SKIP_RC:-77}"
+export OPENVPN_BINARY="$(readlink -f ${top_builddir}/src/openvpn/openvpn)"
+export WORK_DIR="$(readlink -f ${top_srcdir}/sample/)"
+
+if ! which python3 > /dev/null; then
+    echo "$0: Python3 not found, skipping connection tests."
+    exit "${TCLIENT_SKIP_RC}"
+fi
+
+if ! python3 -m pytest --version 2> /dev/null; then
+    echo "$0: Pytest not found, skipping connection tests."
+    exit "${TCLIENT_SKIP_RC}"
+fi
+
+# TODO - possible improvements
+# - Create and run from venv?
+# - Integrate as separate target through Makefile.am ?
+# - Use configure to create test config file ?
+(cd "${top_srcdir}/tests/connection_tests" && python3 -m pytest -v)
-- 
2.25.1


