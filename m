MIME-Version: 1.0
In-Reply-To: <3453b4110907281422u4284faen6cd632e62f11cdf7@...278...>
References: <4A5EFE61.3020100@...41...>
	<3453b4110907280133n32070ed3rd93598fd1b64740e@...278...>
	<9e0cf0bf0907280218p25c081f7v203b4780309cb6b9@...278...>
	<4A6EFCFF.2090400@...1114...>
	<9e0cf0bf0907280650i3dabf036gc9e2f8c745823e15@...278...>
	<4A6F05B0.4020602@...1114...>
	<9e0cf0bf0907280720y45b629d5sd7fe3d2525811280@...278...>
	<3453b4110907281129x509c2bb1rbbfe4a817765e503@...278...>
	<4A6F634E.7020202@...1114...>
	<3453b4110907281422u4284faen6cd632e62f11cdf7@...278...>
Date: Wed, 29 Jul 2009 07:47:57 +0300
Message-ID: <9e0cf0bf0907282147n3dcdb7f6ue91065cc2d606f72@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Sebastien Raveau <sebastien.raveau@...1231...>
Cc: openvpn-devel@lists.sourceforge.net

Well,
I do not understand you guys.

If you think SELinux is so great, why do you need chroot?
It is like you put some money in safe, and then put the safe into
another safe, it never ends... Why only two safe, let's put another
safe...
I know that this is the approach many of security advisors use, but I
never could have found the logic.
If you want to keep your money safe use a single safe and select the
strongest one.

And final note regarding the iproute wrapper.
It is a *WRAPPER*, if I needed top secured implementation I would have
created a daemon listening to network change requests using unix
domain sockets, wrap this up in SELinux profile, and implementing a
logic that allows only changes to tap/tun interface with specific
attributes, and allowing routing table update with specific details.
Then add a wrapper that uses the unix domain socket in order to access
the daemon. OpenVPN will use the wrapper so it needs no special
privilege. The daemon validates what SELinux or any other security
product cannot validate: Network configuration changes. All done
within a valid and separate context.

As I wrote earlier, most of OpenVPN configurations need to execute
iproute also during session. For example, if you like to connect two
sites, your super SELinux secured solution will work only at one site.

No need to discuss this further. I get your point.

Alon.

