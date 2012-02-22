Message-ID: <4F451CDC.2010709@...1114...>
Date: Wed, 22 Feb 2012 17:50:36 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz34oFXrQ8vh5qXcEFPC3wA8Qhn7ivzLKasB=B9mOCKyZQ@...278...>
	<4F43BEB5.6050404@...1114...>
	<CAOazyz2rRpsKzitWS5bWe8Ug7ut=ODQy9PDkq7v4Aa7E1ygHHA@...278...>
	<4F43D9B0.6010900@...1114...>
	<CAOazyz0Z4Lv=qDN1r_W504vBOgaF1YWiNs+9j_MCorACOzfyzQ@...278...>
	<4F43EE92.50802@...515...> <20120221202223.GE7024@...1296...>
	<CAOazyz1vAeOLWrqoYgK+tOba1yfx4uyhoqt3Gq1+7LLGK9A-+Q@...278...>
	<4F451BD3.9030400@...1114...>
In-Reply-To: <4F451BD3.9030400@...1114...>
Subject: Re: [Openvpn-devel] [RFC] openssl minimum supported version
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/02/12 17:46, David Sommerseth wrote:
> On 22/02/12 17:13, Alon Bar-Lev wrote:
>> Dear project managers. I need a decision regarding the minimum 
>> supported openssl.
> 
> I'd say we support these libraries and tools as the oldest supported:
> 
>> =autoconf-2.59 =automake-1.9 =libtool-1.5.22 =lzo-2.02
>> =openssl-0.9.8 =pkcs11-helper-1.07

(Thank you Thunderbird for screwing up my mail!)

Hopefully this passes through without any issues

 * >=autoconf-2.59
 * >=automake-1.9
 * >=libtool-1.5.22
 * >=lzo-2.02
 * >=openssl-0.9.8
 * >=pkcs11-helper-1.07

> This covers RHEL5 environments easily.
> 
> James: RHEL4 support officially ends in 6 days from Red Hat.  I'm
> here proposing to kill RHEL4 support, and have RHEL5 support as the
> minimum. If people want to be stuck on RHEL4, they're stuck with
> OpenVPN 2.2 and older.
> 
> I would even say that if nobody rejects this idea within the next 72 
> hours, then it is decided.  If James can reply and give it an ACK, it 
> will be valid instantly.
> 
> Is that fine with everyone?


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9FHNwACgkQDC186MBRfrpa4gCglUZuoEbnt1rKHUpxqkBW+Cmg
Ss4AoITDMPQCB/dcclG/DN0fMoGOxSDt
=7bQC
-----END PGP SIGNATURE-----

