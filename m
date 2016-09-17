From: David Sommerseth <davids@...515...>
Date: Sat, 17 Sep 2016 16:20:15 +0300
Message-Id: <1474118415-14666-1-git-send-email-davids@...515...>
In-Reply-To: <1472146337-9430-1-git-send-email-davids@...515...>
References: <1472146337-9430-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCHv2] Document the --auth-token option
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

This isn't an option to be used directly in any configuration files,
but to be used via --client-connect scripts or --plugin making use of
OPENVPN_PLUGIN_CLIENT_CONNECT or OPENVPN_PLUGIN_CLIENT_CONNECT_V2.

 [v2 - Added lacking .B styling of options
     - Clarified the token life time ]

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/openvpn.8 | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 2f42636..be9dc47 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4,7 +4,7 @@
 .\"             packet encryption, packet authentication, and
 .\"             packet compression.
 .\"
-.\"  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+.\"  Copyright (C) 2002-2016 OpenVPN Technologies, Inc. <sales@...515...>
 .\"
 .\"  This program is free software; you can redistribute it and/or modify
 .\"  it under the terms of the GNU General Public License version 2
@@ -34,7 +34,7 @@
 .\" .ft -- normal face
 .\" .in +|-{n} -- indent
 .\"
-.TH openvpn 8 "17 November 2008"
+.TH openvpn 8 "25 August 2016"
 .\"*********************************************************
 .SH NAME
 openvpn \- secure IP tunnel daemon.
@@ -2931,6 +2931,7 @@ This is a partial list of options which can currently be pushed:
 .B \-\-ip\-win32, \-\-dhcp\-option,
 .B \-\-inactive, \-\-ping, \-\-ping\-exit, \-\-ping\-restart,
 .B \-\-setenv,
+.B \-\-auth\-token,
 .B \-\-persist\-key, \-\-persist\-tun, \-\-echo,
 .B \-\-comp\-lzo,
 .B \-\-socket\-flags,
@@ -5023,6 +5024,57 @@ This directive does not affect the
 username/password.  It is always cached.
 .\"*********************************************************
 .TP
+.B \-\-auth\-token token
+This is not an option to be used directly in any configuration files,
+but rather push this option from a
+.B \-\-client\-connect
+script or a
+.B \-\-plugin
+which hooks into the OPENVPN_PLUGIN_CLIENT_CONNECT or
+OPENVPN_PLUGIN_CLIENT_CONNECT_V2 calls.  This option provides
+a possibility to replace the clients password with an authentication
+token during the lifetime of the OpenVPN client.
+
+Whenever the connection is renegotiated and the
+.B \-\-auth\-user\-pass\-verify
+script or
+.B \-\-plugin
+making use of the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY hook is
+triggered, it will pass over this token as the password
+instead of the password the user provided.  The authentication
+token can only be reset by a full reconnect where the server
+can push new options to the client.  The password the user entered
+is never preserved once an authentication token have been set.  If
+the OpenVPN server side rejects the authentication token, the
+client will receive an AUTH_FAIL and disconnect.
+
+The purpose of this is to enable two factor authentication
+methods, such as HOTP or TOTP, to be used without needing to
+retrieve a new OTP code each time the connection is renegotiated.
+Another use case is to cache authentication data on the client
+without needing to have the users password cached in memory
+during the life time of the session.
+
+To make use of this feature, the
+.B \-\-client\-connect
+script or
+.B \-\-plugin
+needs to put
+
+.nf
+.ft 3
+.in +4
+push "auth\-token UNIQUE_TOKEN_VALUE"
+.in -4
+.ft
+.fi
+
+into the file/buffer for dynamic configuration data.  This
+will then make the OpenVPN server to push this value to the
+client, which replaces the local password with the
+UNIQUE_TOKEN_VALUE.
+.\"*********************************************************
+.TP
 .B \-\-tls\-verify cmd
 Run command
 .B cmd
-- 
1.8.3.1


