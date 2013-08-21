Message-ID: <52147A34.7050406@...1227...>
Date: Wed, 21 Aug 2013 10:28:36 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <51C77F12.1090802@...515...> <5210B1EB.7000409@...1227...>
	<20130821072739.GG16543@...1296...>
In-Reply-To: <20130821072739.GG16543@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] TLS versioning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: James Yonan <james@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 21.08.13 09:27, schrieb Gert Doering:
> Hi,
>
> On Sun, Aug 18, 2013 at 01:37:15PM +0200, Arne Schwabe wrote:
>> Am 24.06.13 01:04, schrieb James Yonan:
>>> This is the TLS versioning patch as discussed in last Thursday's IRC
>>> meeting.
> [..]
>> OpenVPN for Android already ships this change and there seem some
>> incompatibility. I have a report from a user which reports that against
>> his OpenVPN server (Tomato Router Firmware - OpenVPN 2.2.2):
>
> So if I understand the issue right, it's caused by OpenSSL 0.96 on the
> server side (which is ancient, but obviously still shipping).
>
> I think we have three options now, and need to decide
>
>  - tell users "this is how it is, your server side is a gaping security
>    hole due to ancient OpenSSL (do we have facts to back that?), get
>    your server upgraded!"
>    - not overly nice, especially if the user has no real control about
>      what router firmware bundlers ship
>
>  - back out the change
>    - I'd rather not do that, as 2.3.x will be around for a long time, and
>      we *want* to be able to use higher TLS versions if possible
>
>  - introduce a new option
>      --talking-to-old-server-disable-tls-nego-yes-stupid-I-know
>    that will run-time disable TLS negotiation, falling back to the old
>    code path that only does TLS 1.0
>    - while making our code even more complex and adding even more option,
>      this would give us "higher TLS version" security, and a knob to get
>      back compatibility for those setups where OpenSSL on either side
>      is too broken to handle TLS 1.1 or 1.2
>    - we could name this option "--tls-max-version", to complement the
>      existing --tls-min-version option to leave negotiation enabled, but
>      set bounds - from some other project, I have learned that there are
>      combinations of OpenSSL versions where TLS 1.0 and 1.1 negotiate
>      fine, but 1.2 fails (just hangs) - so that might be a more clean
>      approach.  Add big warning to the log if used .-)
>
> I can neither comment on the problem nor write the code, so I can only
> try to get the discussion going to fix this.
>
Well I am not really sure what is going on on the Tomato firmware. I
build a OpenSSL 0.9.7e (0.9.7e-3sarge3 to be exact, might already have
some fixes in it, Tomato has 0.9.8d) on amd64 + OpenVPN 2.2.2 and that
worked against 2.4-master. Before backing out the change or adding a
backward fix I would like to understand what the real problem here is.

Arne



Arne
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlIUejQACgkQe8+cMNS4zRdYwACguUMi+4kMLDuKfgLVH3BScQLa
Z4YAn0EItxf2cOsxKyf6deQYEbo8VAfH
=0r25
-----END PGP SIGNATURE-----


