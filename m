MIME-Version: 1.0
References: <20230709231929.195048-1-jeremyfleischman@...277...>
 <a647bbd5.AWYAACY5qkoAAAAAAAAAAW9e-ykAAYCsnhYAAAAAABXTlQBk9Q8z@...2677...>
In-Reply-To: <a647bbd5.AWYAACY5qkoAAAAAAAAAAW9e-ykAAYCsnhYAAAAAABXTlQBk9Q8z@...2677...>
From: Jeremy Fleischman <jeremyfleischman@...277...>
Date: Mon, 4 Sep 2023 10:46:37 -0700
Message-ID: <CAHpv4cMjwtdViA8A0yqZjpeTk0Syb6jZogm4oNXsQ+bM1XMTjA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix StatusChangeCallback so it works
 without a LogCallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <dazo+openvpn@...2108...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hey David,

On Sun, Sep 3, 2023 at 3:56=E2=80=AFPM David Sommerseth
<dazo+openvpn@...2108...> wrote:
>
> First of all; sorry it's taken so long time to get back to you.  GH
> issue #171 has unfortunately taken most of my time, so this patch went
> on the side burner.

No worries, thanks for getting around to this!

> I've looked at your patch, and I wonder if it can be done a bit simpler.
>   I'm open to hear your views; I might have overlooked some details.

I like this! At a high level, your proposal consolidates the logic
about "who needs LogForward enabled" into this new __set_log_forward
method. It maybe makes it a little more complicated to add more
callbacks in the future that require LogForward, but that's an
incredibly minor point, and I don't think it's worth the complication
of the reference counting implementation I originally proposed.

I took your idea, and rolled with it a bit. I think we can simplify
things a bit further if we let __set_log_forward be completely
responsible for determining if LogForward should be enabled (it knows
if it should be enabled because it can check if there are any
callbacks registered that require LogForward). How does this updated
diff look?

diff --git a/src/python/openvpn3/SessionManager.py
b/src/python/openvpn3/SessionManager.py
index 3632790..1a567be 100644
--- a/src/python/openvpn3/SessionManager.py
+++ b/src/python/openvpn3/SessionManager.py
@@ -114,6 +114,7 @@ def __init__(self, dbuscon, objpath):
         self.__log_callback =3D None
         self.__status_callback =3D None
         self.__deleted =3D False
+        self.__log_forward_enabled =3D False


     def __del__(self):
@@ -291,16 +292,11 @@ def LogCallback(self, cbfnc):

dbus_interface=3D'net.openvpn.v3.backends',
                                                bus_name=3D'net.openvpn.v3.=
log',
                                                path=3Dself.__session_path)
-            self.__session_intf.LogForward(True)
         else:
-            try:
-                self.__session_intf.LogForward(False)
-            except dbus.exceptions.DBusException:
-                # If this fails, the session is typically already removed
-                pass
             self.__dbuscon.remove_signal_receiver(self.__log_callback, 'Lo=
g')
             self.__log_callback =3D None

+        self.__set_log_forward()

     ##
     #  Subscribes to the StatusChange signals for this session and register
@@ -318,10 +314,14 @@ def StatusChangeCallback(self, cbfnc):
                                                bus_name=3D'net.openvpn.v3.=
log',
                                                path=3Dself.__session_path)
         else:
-            self.__dbuscon.remove_signal_receiver(self.__status_callback,
-                                                  'StatusChange')
-            self.__status_callback =3D None
+            # Only remove the callback if there actually *is* a callback
+            # currently.
+            if self.__status_callback is not None:
+                self.__dbuscon.remove_signal_receiver(self.__status_callba=
ck,
+                                                      'StatusChange')
+                self.__status_callback =3D None

+        self.__set_log_forward()


     ##
@@ -417,6 +417,30 @@ def GetDCO(self):
     def SetDCO(self, dco):
         self.__prop_intf.Set('net.openvpn.v3.sessions', 'dco', dco)

+    ##
+    #  Internal method to enable/disable LogForward as needed.
+    #  Must be called whenever a callback that needs LogForward enabled is
+    #  added or removed.
+    #
+    def __set_log_forward(self):
+        # The LogCallback and the StatusChangeCallback both need LogForward
+        # enabled. In other words, LogForward should be enabled iff one or=
 both
+        # of those callbacks are registered.
+        should_log_forward_be_enabled =3D (
+            self.__log_callback is not None or self.__status_callback
is not None
+        )
+
+        if should_log_forward_be_enabled and not self.__log_forward_enable=
d:
+            self.__session_intf.LogForward(True)
+            self.__log_forward_enabled =3D True
+        elif not should_log_forward_be_enabled and self.__log_forward_enab=
led:
+            try:
+                self.__session_intf.LogForward(False)
+            except dbus.exceptions.DBusException:
+                # If this fails, the session is typically already removed
+                pass
+
+            self.__log_forward_enabled =3D False


 ##

