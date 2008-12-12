Message-ID: <20246.65.118.50.246.1229116877.squirrel@...1166...>
Date: Fri, 12 Dec 2008 15:21:17 -0600 (CST)
From: "Daniel Johnson" <Progman2000@...1085...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Patch for plugin/auth-pam.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When I began testing OpenVPN v2.1_rc9 I was having trouble authenticating
to the MS Active Directory through auth-pam and Samba.  I used the
following line in my configs (without the linebreak of course):

plugin /opt/openvpn/openvpn-auth-pam.so
                   "openvpn login OURDOMAIN+USERNAME password PASSWORD"

Finally I turned on more verbose logging and found that the plugin did
not recognize "USERNAME" as something to replace, because it expected
the string to be surrounded by whitespace.  I wrote the following patch
to correct this.  I hope you find it useful,

http://thor.chguernsey.com/temp/auth-pam.patch  (2kb)
http://thor.chguernsey.com/temp/auth-pam.patch.sig
MD5: 6560cbdfe24b3469dcb551d8963efdfa *auth-pam.patch

Daniel Johnson
Progman2000@...1085...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFJQtUw6vGcUBY+ge8RAneeAKD4WGMULgEqCUM3foF1QiTNByhCYgCg2/nS
h77baQ+tTtzj15yQXK7dXEI=
=ZtGp
-----END PGP SIGNATURE-----


diff -Naur openvpn-2.1_rc9/plugin/auth-pam/auth-pam.c
openvpn-2.1_rc9_dj/plugin/auth-pam/auth-pam.c
--- openvpn-2.1_rc9/plugin/auth-pam/auth-pam.c	2008-07-14
18:49:16.000000000 +0000
+++ openvpn-2.1_rc9_dj/plugin/auth-pam/auth-pam.c	2008-10-07
21:15:43.000000000 +0000
@@ -111,6 +111,33 @@
 /* Background process function */
 static void pam_server (int fd, const char *service, int verb, const
struct name_value_list *name_value_list);

+static char * searchandreplace(const char *tosearch, const char
*searchfor, const char *replacewith) {
+  /*  Read 'tosearch', replace all occurences of 'searchfor' with
'replacewith' and return
+   *  a pointer to the NEW string.  Does not modify the input strings. 
Will not enter an
+   *  infinite loop with clever 'searchfor' and 'replacewith' strings.
+   *  Daniel Johnson - Progman2000@...1085... / djohnson@...1167...
+   */
+  if (!tosearch || !searchfor || !replacewith) return 0;
+  if (!strlen(tosearch) || !strlen(searchfor) || !strlen(replacewith))
return 0;
+
+  const char *searching=tosearch;
+  char *scratch;
+  char temp[strlen(tosearch)*10];
+  temp[0]=0;
+
+  scratch = strstr(searching,searchfor);
+  if (!scratch) return strdup(tosearch);
+
+  while (scratch) {
+    strncat(temp,searching,scratch-searching);
+    strcat(temp,replacewith);
+
+    searching=scratch+strlen(searchfor);
+    scratch = strstr(searching,searchfor);
+  }
+  return strdup(temp);
+}
+
 /*
  * Given an environmental variable name, search
  * the envp array for its value, returning it
@@ -557,10 +584,10 @@
 			     match_name,
 			     match_value);

-		  if (!strcmp (match_value, "USERNAME"))
-		    return_value = up->username;
-		  else if (!strcmp (match_value, "PASSWORD"))
-		    return_value = up->password;
+		  if (strstr(match_value, "USERNAME"))
+		    return_value = searchandreplace(match_value, "USERNAME",
up->username);
+		  else if (strstr(match_value, "PASSWORD"))
+		    return_value = searchandreplace(match_value, "PASSWORD",
up->password);
 		  else
 		    return_value = match_value;




