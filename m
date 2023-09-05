MIME-Version: 1.0
References: <fbf44b37-f89f-9329-862c-5d1015f6a4a8@...2108...>
 <c370f430-80c6-5fea-6233-042d5069a14e@...2108...>
 <CAHpv4cM_p+zAvCyqmu5cW1aVhM9DoOtRhW5svrBpsVNdj83j1g@...278...>
 <32f74cd6.AVMAACPKxlQAAAAAAAAAAW9e-ykAAYCsnhYAAAAAABXTlQBk9mOS@...2677...>
In-Reply-To: <32f74cd6.AVMAACPKxlQAAAAAAAAAAW9e-ykAAYCsnhYAAAAAABXTlQBk9mOS@...2677...>
From: Jeremy Fleischman <jeremyfleischman@...277...>
Date: Mon, 4 Sep 2023 22:03:14 -0700
Message-ID: <CAHpv4cMAG0QLtjz3TDYasRdG2+PKKUwt6MyP65BxSVSoarLHgg@...278...>
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
Content-Transfer-Encoding: 8bit
To: David Sommerseth <dazo+openvpn@...2108...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

> I have a feeling we're missing a check here.

Got it! You're right, I've added that in the v2 version of this patch
(see below).

diff --git a/src/python/openvpn3/SessionManager.py
b/src/python/openvpn3/SessionManager.py
index 3632790..a175015 100644
--- a/src/python/openvpn3/SessionManager.py
+++ b/src/python/openvpn3/SessionManager.py
@@ -114,6 +114,7 @@ def __init__(self, dbuscon, objpath):
         self.__log_callback = None
         self.__status_callback = None
         self.__deleted = False
+        self.__log_forward_enabled = False


     def __del__(self):
@@ -284,6 +285,16 @@ def GetFormattedStatistics(self,
prefix='Connection statistics:\n', format_str='
     #
     #
     def LogCallback(self, cbfnc):
+        if cbfnc is not None and self.__log_callback is not None:
+            # In this case, the program must first disable the
+            # current LogCallback() before setting a new one.
+            raise RuntimeError('LogCallback() is already enabled')
+
+        if cbfnc is None and self.__log_callback is None:
+            # This is fine: disabling a callback when there is no callback is a
+            # simple no-op.
+            return
+
         if cbfnc is not None:
             self.__log_callback = cbfnc
             self.__dbuscon.add_signal_receiver(cbfnc,
@@ -291,16 +302,14 @@ def LogCallback(self, cbfnc):

dbus_interface='net.openvpn.v3.backends',
                                                bus_name='net.openvpn.v3.log',
                                                path=self.__session_path)
-            self.__session_intf.LogForward(True)
         else:
-            try:
-                self.__session_intf.LogForward(False)
-            except dbus.exceptions.DBusException:
-                # If this fails, the session is typically already removed
-                pass
-            self.__dbuscon.remove_signal_receiver(self.__log_callback, 'Log')
-            self.__log_callback = None
+            # Only remove the callback if there actually *is* a callback
+            # currently.
+            if self.__log_callback is not None:
+
self.__dbuscon.remove_signal_receiver(self.__log_callback, 'Log')
+                self.__log_callback = None

+        self.__set_log_forward()

     ##
     #  Subscribes to the StatusChange signals for this session and register
@@ -310,6 +319,16 @@ def LogCallback(self, cbfnc):
     #     (integer) StatusMajor, (integer) StatusMinor, (string) message
     #
     def StatusChangeCallback(self, cbfnc):
+        if cbfnc is not None and self.__status_callback is not None:
+            # In this case, the program must first disable the
+            # current StatusChangeCallback() before setting a new one.
+            raise RuntimeError('StatusChangeCallback() is already enabled')
+
+        if cbfnc is None and self.__status_callback is None:
+            # This is fine: disabling a callback when there is no callback is a
+            # simple no-op.
+            return
+
         if cbfnc is not None:
             self.__status_callback = cbfnc
             self.__dbuscon.add_signal_receiver(cbfnc,
@@ -318,10 +337,14 @@ def StatusChangeCallback(self, cbfnc):
                                                bus_name='net.openvpn.v3.log',
                                                path=self.__session_path)
         else:
-            self.__dbuscon.remove_signal_receiver(self.__status_callback,
-                                                  'StatusChange')
-            self.__status_callback = None
+            # Only remove the callback if there actually *is* a callback
+            # currently.
+            if self.__status_callback is not None:
+                self.__dbuscon.remove_signal_receiver(self.__status_callback,
+                                                      'StatusChange')
+                self.__status_callback = None

+        self.__set_log_forward()


     ##
@@ -417,6 +440,30 @@ def GetDCO(self):
     def SetDCO(self, dco):
         self.__prop_intf.Set('net.openvpn.v3.sessions', 'dco', dco)

+    ##
+    #  Internal method to enable/disable LogForward as needed.
+    #  Must be called whenever a callback that needs LogForward enabled is
+    #  added or removed.
+    #
+    def __set_log_forward(self):
+        # The LogCallback and the StatusChangeCallback both need LogForward
+        # enabled. In other words, LogForward should be enabled iff one or both
+        # of those callbacks are registered.
+        should_log_forward_be_enabled = (
+            self.__log_callback is not None or self.__status_callback
is not None
+        )
+
+        if should_log_forward_be_enabled and not self.__log_forward_enabled:
+            self.__session_intf.LogForward(True)
+            self.__log_forward_enabled = True
+        elif not should_log_forward_be_enabled and self.__log_forward_enabled:
+            try:
+                self.__session_intf.LogForward(False)
+            except dbus.exceptions.DBusException:
+                # If this fails, the session is typically already removed
+                pass
+
+            self.__log_forward_enabled = False


 ##

