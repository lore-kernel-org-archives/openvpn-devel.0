Message-ID: <4B9907DF.7030609@...1114...>
Date: Thu, 11 Mar 2010 16:10:23 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B9515FF.6000704@...41...>	<20100308174321.GA25238@...1296...>
	<4B966A98.4000206@...41...>
	<jwvsk87dlhk.fsf-monnier+inbox@...1269...>
In-Reply-To: <jwvsk87dlhk.fsf-monnier+inbox@...1269...>
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
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
To: Stefan Monnier <monnier@...1268...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/03/10 14:51, Stefan Monnier wrote:
>> Implementing a DHCP client within OpenVPN tends to make this a more
>> self-contained problem.
> 
> I don't think OpenVPN should get into the DHCP business.
> Especially because this is not a problem specific to OpenVPN: the same
> problem of refreshing DHCP info happens with ethernet and with wifi when
> you disconnect and reconnect.
> 
> Various solutions to this problem already exist: a tool (e.g. ifplugd)
> can monitor the interface's status, or OpenVPN can be instructed (via
> its script hooks) to run commands upon (re|dis)connection.
> 
> These existing solutions are better because they profit from the general
> infrastructure and will hence blend in much better.  E.g. they will
> automatically adopt the global DHCP customizations.
> 

I agree to your points, from a theoretical point of view.  But from a
practical point of view, I'm not sure how possible it is to find a more
generic solution which can be used on all *nix based setups.  AFAIK,
ifplugd is very Linux oriented, and depends on features found in that
kernel.  What about *BSD, Solaris or other Unix based OSes?

Another issue with these programs is that they often do need a
configuration file to take care of the interface setup.  On some Linux
distroes, ifplugd can even cause conflicts with other similar solutions
which that distro prefers over ifplugd.

I'm running Fedora 12, and ifplugd is available but not installed.  I
presume that's because NetworkManager is taking care of everything with
networking.  In fact, I know that if I manually start dhclient on an
extra device with NetworkManager, I often experience that NetworkManager
reclaims control of that device, and it looses its IP address.  In this
case, I'd say that OpenVPN should integrate against NetworkManager
instead.  But that's not sustainable either.

We do need this feature into OpenVPN.  But, as Gert stated, you move
complexity from one place to another place.  It's not given now it will
be easier to implement DHCP features inside OpenVPN or to get something
started outside OpenVPN ... just because it's not a de-facto solution
which even distroes make use of.

In my point of view, it's more important to find a solution which will
be easy to maintain in the OpenVPN code and which doesn't give a
headache to the package maintainers or system admins needing to
configure OpenVPN.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuZB9sACgkQDC186MBRfrqw8QCeMjOgwpctv+G7BMqGa68IVbr+
K+gAn3gXx9/HKnmX++pyeOwCRnd3Q2yM
=l4QC
-----END PGP SIGNATURE-----

