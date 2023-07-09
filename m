From: Jeremy Fleischman <jeremyfleischman@...277...>
Date: Sun,  9 Jul 2023 16:19:26 -0700
Message-ID: <20230709231929.195048-1-jeremyfleischman@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix StatusChangeCallback so it works
 without a LogCallback
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

`StatusChangeCallback` requires that LogForward be enabled, which
previously only happened in `LogCallback`. Now both of them do it, which
requires a bit of bookkeeping. This fixes
https://github.com/OpenVPN/openvpn3-linux/issues/197

Notes:

1. I'm not sure if this would place nicely with a multithreaded program
   or not. Hopefully that's not something we care to support?
2. To keep the bookkeeping accurate, I opted to explictly remove any
   preexisting callbacks before registering a new one. This means that
   when you're clobbering an existing LogCallback (for example), you'll
   actually end disabling LogForward right before you re-enable it. I
   don't think this is a big deal, but just wanted to call it out.

Signed-off-by: Jeremy Fleischman <jeremyfleischman@...277...>
---
 src/python/openvpn3/SessionManager.py | 63 ++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 12 deletions(-)

diff --git a/src/python/openvpn3/SessionManager.py b/src/python/openvpn3/SessionManager.py
index 3632790..05126aa 100644
--- a/src/python/openvpn3/SessionManager.py
+++ b/src/python/openvpn3/SessionManager.py
@@ -114,6 +114,7 @@ def __init__(self, dbuscon, objpath):
         self.__log_callback = None
         self.__status_callback = None
         self.__deleted = False
+        self.__LogForward_receiver_count = 0
 
 
     def __del__(self):
@@ -285,22 +286,24 @@ def GetFormattedStatistics(self, prefix='Connection statistics:\n', format_str='
     #
     def LogCallback(self, cbfnc):
         if cbfnc is not None:
+            # Remove the existing callback if there is one.
+            if self.__log_callback is not None:
+                self.LogCallback(None)
+
             self.__log_callback = cbfnc
             self.__dbuscon.add_signal_receiver(cbfnc,
                                                signal_name='Log',
                                                dbus_interface='net.openvpn.v3.backends',
                                                bus_name='net.openvpn.v3.log',
                                                path=self.__session_path)
-            self.__session_intf.LogForward(True)
+            self.__add_LogForward_receiver()
         else:
-            try:
-                self.__session_intf.LogForward(False)
-            except dbus.exceptions.DBusException:
-                # If this fails, the session is typically already removed
-                pass
-            self.__dbuscon.remove_signal_receiver(self.__log_callback, 'Log')
-            self.__log_callback = None
-
+            # Only remove the callback if there actually *is* a callback
+            # currently.
+            if self.__log_callback is not None:
+                self.__remove_LogForward_receiver()
+                self.__dbuscon.remove_signal_receiver(self.__log_callback, 'Log')
+                self.__log_callback = None
 
     ##
     #  Subscribes to the StatusChange signals for this session and register
@@ -311,16 +314,25 @@ def LogCallback(self, cbfnc):
     #
     def StatusChangeCallback(self, cbfnc):
         if cbfnc is not None:
+            # Remove the existing callback if there is one.
+            if self.__status_callback is not None:
+                self.StatusChangeCallback(None)
+
             self.__status_callback = cbfnc
             self.__dbuscon.add_signal_receiver(cbfnc,
                                                signal_name='StatusChange',
                                                dbus_interface='net.openvpn.v3.backends',
                                                bus_name='net.openvpn.v3.log',
                                                path=self.__session_path)
+            self.__add_LogForward_receiver()
         else:
-            self.__dbuscon.remove_signal_receiver(self.__status_callback,
-                                                  'StatusChange')
-            self.__status_callback = None
+            # Only remove the callback if there actually *is* a callback
+            # currently.
+            if self.__status_callback is not None:
+                self.__remove_LogForward_receiver()
+                self.__dbuscon.remove_signal_receiver(self.__status_callback,
+                                                      'StatusChange')
+                self.__status_callback = None
 
 
 
@@ -417,6 +429,33 @@ def GetDCO(self):
     def SetDCO(self, dco):
         self.__prop_intf.Set('net.openvpn.v3.sessions', 'dco', dco)
 
+    ##
+    #  Internal method to increase the count of how many signal receivers need
+    #  LogForward. Turns on LogForward if this is the first receiver.
+    #
+    def __add_LogForward_receiver(self):
+        # This is our first need for LogForward. Turn it on.
+        if self.__LogForward_receiver_count == 0:
+            self.__session_intf.LogForward(True)
+
+        self.__LogForward_receiver_count += 1
+
+    ##
+    #  Internal method track to reduce the count of how many signal receivers
+    #  need LogForward. Turns off LogForward if this was the last receiver.
+    #
+    def __remove_LogForward_receiver(self):
+        assert self.__LogForward_receiver_count > 0
+        self.__LogForward_receiver_count -= 1
+
+        # No receivers are left in need of LogForward. Turn it off.
+        if self.__LogForward_receiver_count == 0:
+            try:
+                self.__session_intf.LogForward(False)
+            except dbus.exceptions.DBusException:
+                # If this fails, the session is typically already removed
+                pass
+
 
 
 ##
-- 
2.41.0


