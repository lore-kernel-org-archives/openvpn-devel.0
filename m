Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170701112951.19119-1-steffan@...1856...>
 <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
 <7ca195bc-c088-5ccc-3b2f-07e2dec215ee@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a34f22d4-69c1-f5ab-8c93-bc8fee78a181@...2080...>
Date: Mon, 14 Aug 2017 13:27:53 +0200
MIME-Version: 1.0
In-Reply-To: <7ca195bc-c088-5ccc-3b2f-07e2dec215ee@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oo8vjPVMVciVLICCwCsh2PevlIVqpd0wr"
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --keysize
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oo8vjPVMVciVLICCwCsh2PevlIVqpd0wr
Content-Type: multipart/mixed; boundary="onOevT2cE9pudBsr06s9jmWAlAQErCECm";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a34f22d4-69c1-f5ab-8c93-bc8fee78a181@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --keysize
References: <20170701112951.19119-1-steffan@...1856...>
 <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
 <7ca195bc-c088-5ccc-3b2f-07e2dec215ee@...1435...>
In-Reply-To: <7ca195bc-c088-5ccc-3b2f-07e2dec215ee@...1435...>

--onOevT2cE9pudBsr06s9jmWAlAQErCECm
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 14/08/17 13:17, Steffan Karger wrote:
> Hi,
>=20
> On 14-08-17 12:36, David Sommerseth wrote:
>> On 01/07/17 13:29, Steffan Karger wrote:
>>> The --keysize option can only be used with already deprecated ciphers,
>>> such as CAST5, RC2 or BF.  Deviating from the default keysize is
>>> generally not a good idea (see man page text), and otherwise only
>>> complicates our code.>
>>> (If this patch is accepted, I'll send a follow-up patch to remove the
>>> option from the master branch.)
>>
>> I agree to the wanted intention of this change.  But, it hits badly if
>> we remove --keysize on configurations still enforcing BF-CBC with
>> --keysize 256.  I don't have any numbers of how many users uses it; but
>> I know many have preferred BF-CBC for a long time - at least before
>> SWEET32 came and hit us all.  Bare in mind that BF-CBC was the default
>> since 2002-ish (probably even longer, if considering the OpenVPN v1.x
>> branch). And many have added --cipher BF-CBC in their configs despite it
>> was the default.
>>
>> As long as BF-CBC is available, we cannot remove --keysize.  And to
>> remove BF-CBC support, I think that needs a bit longer timespan than
>> v2.5.  Users *must* be far better prepared for that and we need to make
>> loud and clear announcements with such a change.
>>
>> Yes, in all this, I know that NCP is a nice rescue.  As long as everyone
>> either runs v2.4 everywhere or deploys --ncp-ciphers and starts the
>> migration.  But I've lost confidence that the vast majority of our users
>> pays closely attention to such feature changes - thus they won't notice
>> until it stops working.  We need to PUSH this information into their
>> faces, with large posters carrying promises of rainbow coloured unicorns
>> if they comply today(!).  In addition to adding clear warnings in the
>> log files for a looong time.
>>
>> So I propose:
>>
>> - We add the warning about removing --keysize for both v2.4 and v2.5.
>>
>> - Add a warning in v2.4 and v2.5 that ciphers with block sizes < 128
>>   bits will be *removed* in v2.6
>>
>> - When removing those ciphers in v2.6, we can remove --keysize together
>>   with the ciphers, as it will no longer be valid.  But --keysize needs
>>   to be a NOP for some time (with a warning it has no effect), to avoid
>>   OpenVPN stopping to run on upgrades.
>=20
> Okay.  Instead of sending the keysize removal patch, I'll send a patch
> that warns that small block ciphers will be removed in 2.6.
>
> Can you then do s/2.5/2.6/ on the patch, or shall I send a v2?

Yes, I can do that.  I'll also remove the remark ("If this is
accepted...") from the commit message too, commit to master and
cherry-pick to release/2.4.  I'll also use the term "OpenVPN v2.6"
everywhere, to be more precise in the statements.

But we will need to get started on the planning of the public stunts
too.  Getting a wiki page in place would be a nice starting point though.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--onOevT2cE9pudBsr06s9jmWAlAQErCECm--

--oo8vjPVMVciVLICCwCsh2PevlIVqpd0wr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZkYk5AAoJEIbPlEyWcf3yygAQAMnJuCrMvggKc2b+P7tBXwmW
9sRE1klQ/EzvhIeje8VRieEPyqYCaZpdTZKcO8C8z4cJ/p/A9KbMzWpEDwnCvNXf
t7ui52p6HtgdVsvonq02nuwdZ/NryVwqC9zncUT9JuKnxfews9gGnW40CgngXJ/P
KxLWeLpQYOgnq+22KQ0JIMcX3AmUvcyEMXKTKEqmJQwbazeHQrmRDi73JPu+9eIh
tIfoZDY+ysXZtABn5uouNcbh/yEWqIidyUqsiDMB25JHd+w6L/jMWPEhjiZ6t0jS
hIj57jKr+3vIEdSWfUy+G+nbbTi90WmU8g4iIko4fCZGYCJb3GMxTe6FIfzc4sg6
wn05lThkZHLrLjnj5Mk77NzRY7/BRsRH5EOmbs26tOclLyZaH5atckKyOFqim4H0
0JtWsgAKDlTAi9DigAmA2eq/b1TuD3RH/oD3tuIlcqkFD8JhLsw/FdlCrBXevwdw
uxWP0J+EicjsU/dDiy99R4fGhhddwOTWwx5/dKRVWPhoh4ME0/7nPjvnx5Oe4wdw
Si4WLGf3jYtYFF0DcsJPZuRmis6x5wmKM4DJk4SsTMv4+djQbJLpLfWzdrEfWF7j
rYQth2Gw8IlnyJOSf8dspllDMiCkSd2vb6vpk4LJL+n1LPASsJJJcmRQ85M/bdJs
K+jokNg4nnLgZD5V3CHl
=eNPP
-----END PGP SIGNATURE-----

--oo8vjPVMVciVLICCwCsh2PevlIVqpd0wr--

