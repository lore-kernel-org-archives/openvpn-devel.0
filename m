Message-ID: <5228A1DE.5060402@...1227...>
Date: Thu, 05 Sep 2013 17:23:10 +0200
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
>
Okay, I have some new light on the issue. Tomato Firmware seems not be
the same everywhere. I had contact with another user who identified the
Tomato Fork which exhibits this bug. As it turn out the OpenSSL version
is rather modern (1.0.1c).

OpenSSL seems to stripped down to a minimum.

root@...1838...:/tmp/home/root# openssl version -a
openssl:Error: 'version' is an invalid command.

Standard commands
enc            req            rsa            x509

Cipher commands (see the `enc' command for more details)
aes-128-cbc    aes-128-ecb    aes-192-cbc    aes-192-ecb    aes-256-cbc
aes-256-ecb    bf-cbc         bf-ecb

The Makefile lists a lot of no-xxx options
https://github.com/Victek/TomatoRAF/blob/master/release/src/router/openssl/

The problem must be somehting different than a terrible old OpenSSL
version. I am leaning towards a "terrible configured" OpenSSL version
but my understanding of the whole cipher selection and TLS process is
too limited to spot anything.

Arne

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlIood4ACgkQe8+cMNS4zRfP7wCfcA9OHECNvQN8nj59INIXtEt2
ikcAoJa8NUP2z78G+dtf6iG+lJXMOYyA
=xqiF
-----END PGP SIGNATURE-----


