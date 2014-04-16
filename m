From: Holger Kummert <Holger.Kummert@...1516...>
Date: Wed, 16 Apr 2014 12:48:35 +0200
Message-ID: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Fixes for HTTP proxy authentication with NTLM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

one of our customers reported that the NTLM authentication of OpenVPN doesn't 
work. I checked that and found that both NTLM versions didn't work against a
Win2008 server.  The configuration seemed a bit confusing because an
'auth-method' could only be set if an 'authfile' was given (ok, 'stdin' worked also).

When I inspected the code I noticed that both auto-modes for authentication and
the retry mechanism were handled by one single variable (p->options.auth_retry).
In order to fix the general working and to straighten the configuration and internal 
handling I created two patches:


[PATCH 1/2] Get NTLMv1 and NTLMv2 up and running

This patch fixes several problems found in the ntlm-code:
Apply UTF-16 conversion where needed, introduce a proper conversion from UTF-8 to
UTF-16 (the former one worked only for ASCII chars), fix ntlm2 (the assumed length
for the ntlm2-blob was wrong).


[PATCH 2/2] http-proxy: Separate settings for user interaction and authentication auto-behavior

Here a backward compatible re-structuring of the configuration for 'http-proxy' is
introduced: The interact setting (whether the user is prompted for the credentials
again after an auth error) is put into a new keyword. This is now disjoined from
the auth method. The new syntax is like:

   http-proxy server port [authfile | 'interact'] [ auth-method ]

     auth-method := auto | auto-nct | basic | digest | ntlm | ntlm2

The behavior of auth-method == auto or auto-nct works as follows:
If the server requests an authentication method the credentials are
asked from the user.
The new behaviour treats the server request for 'NTLM' in the following way:
The NTLMv2 algorithm is tried first (in order to push higher security). Only
if this fails NTLMv1 will be used. If this also fails the user is asked
for the credentials again depending on the configuration.
  

Any opinions?


Best regards,
Holger


