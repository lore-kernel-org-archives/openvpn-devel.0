Message-ID: <4B8B8AC3.2050803@...1114...>
Date: Mon, 01 Mar 2010 10:37:07 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <54cde1cd4bdc1e82da3cb67831cc45c0@...1228...>	<4B8A6E08.3090204@...1114...>
	<1267415552.30675.2@...1207...>
In-Reply-To: <1267415552.30675.2@...1207...>
Subject: Re: [Openvpn-devel] OpenVPN Pf plugin/small status patch
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/03/10 04:52, Karl O. Pinc wrote:
>>> If one of this files is found the file is used as PF configuration.
>> > Maybe
>>> > > this plugin is useful for someone else.
>> > 
>> > Hi!
>> > 
>> > Thank you for your patches.  I've been looking at both patches, and I
>> > have some questions in regards to this plug-in.
>>
> I think that a vocabulary change could help avoid confusion, depending
> on exactly what the proposed vocabulary is here.  "pf" is the offical
> name for the OpenBSD packet filter.  IIRC it is also ported to FreeBSD
> and perhaps elsewhere.  Using the name "pf" for this plugin could
> be confusing.

Even though I do agree with you, Karl, that the vocabulary can be
confusing, I'm not sure it is up to us to change that.  OpenVPN has
implemented a packet filtering feature which placed in pf.[ch] and seems
to use the abbreviation PF several places in the code.

We may dislike it or not, but we probably can't change that now.  That
this plug-in uses pf in OpenVPN context is in my eyes correct, as it
corresponds to the OpenVPN implementation.  Having that said, it could
be better described in some comments that this plug-in is using
OpenVPN's packet filter implementation.

Anyhow, this topic do deserve a little discussion on the
#openvpn-discussion meeting on Thursdays@...1308...:00 UTC with James.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuLisAACgkQDC186MBRfrouHwCfaLLg9QCtlEEN8CYOJdtQVm+8
qeUAoJUvSKh1XM61khqHFZ55V9kvFMFg
=jtqZ
-----END PGP SIGNATURE-----

