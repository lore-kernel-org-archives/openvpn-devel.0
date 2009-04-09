Date: Thu, 09 Apr 2009 12:44:43 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <1239166995l.18482l.9l@...1207...>
	<F9B005F620B74BD29BB0A36AF509BCED@...576...> <1239203062l.18482l.11l@...1207...>
	<9e0cf0bf0904081546y3daea253u62c234e63a6e5b08@...278...>
	<1239246215l.5600l.0l@...1207...>
	<9e0cf0bf0904082301ia16b642n3781adc357958de3@...278...>
	<1239281926l.5600l.2l@...1207...>
In-Reply-To: <1239281926l.5600l.2l@...1207...> (from kop@...1206... on Thu Apr  9
	07:58:46 2009)
Message-Id: <1239299083l.17083l.3l@...1207...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-A2QpqqDxcti7lzXuiOZR"
Subject: Re: [Openvpn-devel] Unpackged Windows binaries? -- Problems
 building 2.1 rc15 on Windows XP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>, dave <dev@...575...>

--=-A2QpqqDxcti7lzXuiOZR
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


On 04/09/2009 07:58:46 AM, Karl O. Pinc wrote:
>=20
> On 04/09/2009 01:01:50 AM, Alon Bar-Lev wrote:
> > On Thu, Apr 9, 2009 at 6:03 AM, Karl O. Pinc <kop@...1206...> wrote:
> > > It occurs to me that if I want to do more than
> > > beg I should submit a patch, so one is attached.

It occurs to me that it's no good having an unpackaged
Windows binary archive without instructions regarding
how to use it.

Attached is a patch to INSTALL-win32.html that
documents how to make a custom Windows installer using
the archive produced by my previous patch.

I hope OpenVPN will consider these patches for inclusion.

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

--=-A2QpqqDxcti7lzXuiOZR
Content-Type: text/x-patch; charset=us-ascii; name=INSTALL-win32.html.patch
Content-Disposition: attachment; filename=INSTALL-win32.html.patch
Content-Transfer-Encoding: quoted-printable

--- INSTALL-win32.html	2005-10-18 03:46:47.000000000 -0500
+++ INSTALL-win32.html.patched	2009-04-09 12:38:59.000000000 -0500
@@ -829,6 +829,87 @@
=20
 <hr />
=20
+<h2>Notes -- Customizing the Windows installer</h2>
+
+<p><em>This section is for advanced administrators only.</em> The
+recommended approach is to first configure and test your VPN and
+customize the installer only after you have a working
+configuration.</p>
+
+<p>Administrators deploying OpenVPN on Windows may wish to customize
+the Windows installer in a site-specific manner.  Certificates,
+configurations, help files and the like can be included in the
+customized installer to provide a single installer, or an installer
+per-client, that installs everything a site requires to run OpenVPN on
+a client.</p>
+
+<p>Note that an MS Windows machine is <em>not</em> a requirement.</p>
+
+<p>Administrators requiring further customization should see the
+section titled <a href=3D"INSTALL-win32.html#building">Building from
+source</a>.</p>
+
+<p>You will need the following:</p>
+
+<ol>
+        <li>The OpenVPN unpackaged Windows binaries from the <a href=3D"ht=
tp://openvpn.net/index.php/downloads.html">OpenVPN Download</a> page.</li>
+     =20
+	<li>Nullsoft Install System<br />
+	<a href=3D"http://www.nullsoft.com/free/nsis/">http://www.nullsoft.com/fr=
ee/nsis/</a></li>
+</ol>
+
+<p>To make a custom installer use the NSIS installer compiler:</p>
+
+<ol>
+         <li>Unpack the OpenVPN unpackaged windows binaries.  The
+         result should be a directory, the unpacked OpenVPN binary
+         directory.  This directory should have subdirectories.</li>
+
+         <li>Using Internet Explorer (TM) navigate to the
+         <code>nsi</code> subdirectory of the unpacked OpenVPN binary
+         directory.
+
+         <li>Right click on the icon labeled <code>openvpn</code> and
+         select "Compile NSIS script".  Un*x users can use the
+         <code>makensis openvpn.nsi</code> command.</li>
+</ol>
+
+<p>The result should be a Windows installer in the OpenVPN binary
+directory.</p>
+
+<p>A simple customization is to install a configuration file and a
+certificate authority certificate whenever OpenVPN is installed as a
+service.  To do this:</p>
+
+<ol>
+         <li>Put your CA certificate file (i.e. <code>ca.crt</code>)
+         into the <code>nsi</code> subdirectory of the unpacked
+         OpenVPN binary directory.</li>
+
+         <li>Put your configuration file
+         (i.e. <code>myserver.ovpn</code>) into the <code>nsi</code>
+         subdirectory of the unpacked OpenVPN binary directory.  Your
+         configuration file should contain the line<br /><code>ca
+         ca.crt</code><br />to direct OpenVPN to your CA certificate.</li>
+
+         <li> Add the 2 lines:<br /><code>File
+         "myserver.ovpn"</code><br /><code>File "ca.crt"</code><br />
+         to the <code>nsi/openvpn.nsi</code> file at the bottom of
+         the section titled: <code>Section "${P`'RODUCT_NAME} Service"
+         SecService</code></li>
+</ol>
+
+<p>Note that putting your configuration and CA certificate files into
+the <code>nsi</code> subdirectory is not the most organized approach.
+It is simply the easiest way to get started with NSIS.</p>
+
+<p>For more information see <a
+href=3D"http://nsis.sourceforge.net/Docs/"> the NSIS
+Documentation</a>.</p>
+
+<hr />
+
+<a name=3D"building"></a>
 <h2>Notes -- Building from source</h2>
=20
 <p><em>This section is for developers only.</em></p>


--=-A2QpqqDxcti7lzXuiOZR--

