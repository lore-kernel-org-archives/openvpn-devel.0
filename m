From: Charles Duffy <cduffy@...294...>
Message-Id: <1100311165.30425.27.camel@...23...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Certificate Wizard 0.3b - code-related feedback
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Nov 12 18:00:15 2004
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
To: Vlada Macek <tuttle@...289...>
Cc: openvpn-devel@lists.sourceforge.net, it-staff@...296...

Vlada,

In updating my local Certificate Wizard fork to be based off 0.3b, I
observed an issue introduced during your cleanup of my CopyOneFile
function.

My original code:
    snprintf(buffer, MAXLINELEN, "Unable to copy \"%s\" to \"%s\" - error %d: %%s", source, target, errorCode);
    DisplayErrorToUser(errorCode, "Failure copying files", buffer);
 
Your replacement code:
    snprintf(buffer, MAXLINELEN, _("Unable to copy '%s' to '%s' - error %d", 0), source, target, errorCode);
    strcat(buffer, ": %%s");
    DisplayErrorToUser(errorCode, _("Failure copying files", 0), buffer);

These aren't functionally equivalent: The latter results in a literal
'%s' being displayed to the user, whereas the former displays a textual
description of the error message being substituted for the %s (which
snprintf replaces %%s with) inside DisplayErrorToUser. Either the strcat
should only append '%s' rather than '%%s', or '%%s' should be used in
the snprintf (which is the approach I prefer -- but perhaps it
interferes with the internationalization or somesuch?).

Additionally, I noticed a bug from my original code that you inherited:
in DisplayErrorToUser, the MsgBox call should take the description
parameter (rather than a hardcoded string) as its argument.


The sum of non-site-specific changes I've made comes to the following:

diff -ru mycert-src-0.3b.orig/misc.c mycert-src-0.3b.recare/misc.c
--- mycert-src-0.3b.orig/misc.c 2004-11-09 10:02:44.000000000 -0600
+++ mycert-src-0.3b.recare/misc.c       2004-11-12 19:38:27.000000000 -0600
@@ -232,7 +232,7 @@
                  0, NULL);
     
        strncpy(msgBuf, lpMsgBuf, MAXLINELEN);
-       MsgBox(_("Failure copying files", 0), MB_OK, fmt, msgBuf);
+       MsgBox(description, MB_OK, fmt, msgBuf);
        LocalFree(lpMsgBuf);
 }
 
@@ -242,8 +242,7 @@
                char buffer[MAXLINELEN+1];
                int errorCode = GetLastError();
 
-               snprintf(buffer, MAXLINELEN, _("Unable to copy '%s' to '%s' - error %d", 0), source, target, errorCode);
-               strcat(buffer, ": %%s");
+               snprintf(buffer, MAXLINELEN, _("Unable to copy '%s' to '%s' - error %d: %%s", 0), source, target, errorCode);
                DisplayErrorToUser(errorCode, _("Failure copying files", 0), buffer);
                return FALSE;
        }

--- mycert-src-0.3b.orig/mycert.ini     2004-11-09 10:02:44.000000000 -0600
+++ mycert-src-0.3b.recare/mycert.ini   2004-11-12 19:51:45.000000000 -0600
@@ -299,7 +308,7 @@
 #Filename: %s=
 #(Cannot read the file.)=
 #Failure copying files=
-#Unable to copy '%s' to '%s' - error %d=
+#Unable to copy '%s' to '%s' - error %d: %%s=
 #Warning=
 
 


(For the record, since this is a public forum: while "recare" is
mentioned in this message, my employer's name is Catalis Health -- we
changed it recently because ECARE sued us. If you're an employee of
ECARE, don't worry, we really are complying).


