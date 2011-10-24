Message-ID: <4EA534DB.5000201@...1114...>
Date: Mon, 24 Oct 2011 11:50:19 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1319445962-21686-1-git-send-email-dejong@...1435...>
	<1319445962-21686-3-git-send-email-dejong@...1435...>
	<4EA52800.4080205@...1147...>
	<1CED409804E2164C8104F9E623B08B90127CB75804@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B90127CB75804@...1436...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Changed default algorithm for
 PolarSSL to AES-128, as BF is not supported
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
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/10/11 10:58, Adriaan de Jong wrote:
> Unfortunately BF isn't supported in PolarSSL though.
> 
> Do you have any other suggestions? I'm open to most ideas other than
> "implement blowfish" :)

I agree with JJK, that this is probably not a clever idea - to change the
default encryption algorithm.

What about to enforce the use of --cipher when OpenVPN is compiled with
PolarSSL support?  Stating that blowfish isn't supported and another
cipher must explicit be set.


kind regards,

David Sommerseth

>> -----Original Message----- From: Jan Just Keijser
>> [mailto:janjust@...1147...] Sent: maandag 24 oktober 2011 10:55 To:
>> Adriaan de Jong Cc: openvpn-devel@lists.sourceforge.net Subject: Re:
>> [Openvpn-devel] [PATCH 3/3] Changed default algorithm for PolarSSL
>> to AES-128, as BF is not supported
>> 
>> I'd NACK this patch : the default behaviour of OpenVPN should be 
>> independent of the SSL implementation.
>> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6lNNgACgkQDC186MBRfrolbQCgiXigb8L0jiWXgWBs/H+qhiMJ
EpYAnRJHzHUj83lauUAUe0AIxSHpe+hY
=aIa+
-----END PGP SIGNATURE-----

