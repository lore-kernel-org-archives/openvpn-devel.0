Date: Thu, 11 Mar 2010 18:13:12 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <jwvy6hybicq.fsf-monnier+inbox@...1269...> (from
	monnier@...1268... on Thu Mar 11 16:42:07 2010)
Message-Id: <1268352792.5095.1@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Stefan Monnier <monnier@...1268...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 03/11/2010 04:42:07 PM, Stefan Monnier wrote:

> I find the effort would be better spent on working with other people
> trying to make sure that ifplugd/NetworkManager/distributions/...=20
> make
> this setup as troublefree as possible.=20

Exactly.=20=20

As an example appended is a 47 line patch to the Debian Lenny
/etc/init.d/openvpn that should be against sid,
is untested, needs cleanup to get documentation
where it belongs, and probably does not work.
But something like it could probably be made to work.

It's an example, and may be a bad example at that.
I'm not going to make it work or ship it off
to Debian for consideration.

It does not use ifplugd, instead relying on ifup/down
to do the right thing to ensure that the dhcp client
keeps configuring the interface in the event
of trouble.  I've no clue whether that's really
something that ifup/down is supposed to handle.  Perhaps instead
of this it should be calling some helper function
that does the same thing that ifup/down does to
decide what dhcp client to use (working with
the ifupdown people) and then call
ifplugd with the result.

So it's nothing but an idea at this point but
and idea which is probably 2 orders of magnitude
less code than would be required to integrate a
dhcp client into openvpn.  Repeat for RedHat
(and again for Suse?) and you cover, at a guess
80% of the Un*x world and provide plenty of examples
for the maintainers of other distros/OSs=20
(BSD, Solaris, etc.) to follow.  The point
being to help the people who are responsible for=20
systems integration do the integrating because
they will do a better job in the diverse Un*x
world out there.  Even better the task
of maintaining the code gets pushed out
to the distros further reducing the eventual
work required by, according to estimates, 70%.

Reap the benefits of engauging with the larger
FOSS community, not just the OpenVPN community.
Without the larger community OpenVPN would,
at minimum, be greatly diminished.  It makes
sense to reach out.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein

----------------<snip>-------------------

--- /etc/init.d/openvpn	2008-09-17 06:54:05.000000000 -0500
+++ openvpn	2010-03-11 17:47:23.000000000 -0600
@@ -31,6 +31,17 @@
   . /etc/default/openvpn
 fi
=20
+set_tap () {
+      TAP=3D$(grep '^[[:space]]*dev[[:space]]+tap' \
+	         $CONFIG_DIR/$NAME.conf \
+	      | awk '{print $2;};')
+}
+
+tap_needs_dhcp () {
+      [ -n "$TAP" ] \
+        && grep -q '^[[:space::]]*route-gateway[[:space:]]+dhcp
[[:space:]]|$'
+}
+
 start_vpn () {
     if grep -q '^[	 ]*daemon' $CONFIG_DIR/$NAME.conf ; then
       # daemon already given in config file
@@ -62,9 +73,26 @@
       $DAEMON $OPTARGS --writepid /var/run/openvpn.$NAME.pid \
 	      $DAEMONARG $STATUSARG --cd $CONFIG_DIR \
 	      --config $CONFIG_DIR/$NAME.conf || STATUS=3D1
+
+      # This only works if a specific tap device is
+      # configured and the interfaces file has it configured
+      # with dhcp and noauto.  (This note should be in
+      # /usr/share/doc/openvpn/README.Debian.)
+      set_tap
+      if tap_needs_dhcp ; then
+              # Start a dhcp daemon to configure the=20
+              # new interface.
+	  ifup $TAP
+      fi
     fi
 }
 stop_vpn () {
+  set_tap
+  if tap_needs_dhcp ; then
+    # kill the dhcp daemon by shutting down the tap
+    # interface.
+    ifdown $TAP || true
+  fi
   kill `cat $PIDFILE` || true
   rm -f $PIDFILE
   rm -f /var/run/openvpn.$NAME.status 2> /dev/null


