Content-Class: urn:content-classes:message
Message-ID: <4E0DBF8C.1050505@...544...>
Date: Fri, 01 Jul 2011 14:37:32 +0200
From: "Pierre Crokaert" <pct@...544...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Patch for HTTP Proxy with NTLM or error: NTLM
	Proxy-Authorization phase 3 failed: received corrupted data
	from proxy server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello,

This kind of error occurs with some HTTP proxy. This happens when the 
response from the server in phase 2 is longer than 128 bytes, in that 
case the response is truncated because we are only interrested by the 
beginning, but as it is still in base 64 format when it is truncated, it 
must be truncated at a multiple of 4 chars. Today it truncated one char 
too short and it results in a bad base64decode result and response is 
rejected in phase 3.

This was reproduced and fixed on a Microsoft forefront proxy server.

Here is the patch against current git head (dc2ccc825c69...aacd)

@@ -519,7 +519,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
  {
    struct gc_arena gc = gc_new ();
    char buf[512];
-  char buf2[128];
+  char buf2[129]; /* this buffer is a zero terminated base 64 string So it has to be a multiple of 4 char */
    char get[80];
    int status;
    int nparms;
@@ -642,7 +642,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,

                openvpn_snprintf (get, sizeof get, "%%*s NTLM %%%ds", (int) sizeof (buf2) - 1);
                nparms = sscanf (buf, get, buf2);
-              buf2[127] = 0; /* we only need the beginning - ensure it's null terminated. */
+              buf2[128] = 0; /* we only need the beginning - ensure it's null terminated.  and multiple of 4 char*/

                /* check for "Proxy-Authenticate: NTLM TlRM..." */
                if (nparms == 1)



