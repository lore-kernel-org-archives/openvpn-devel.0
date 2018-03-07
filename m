Reply-To: openvpn-devel@lists.sourceforge.net
References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <1520265024-2129-1-git-send-email-arne@...1227...>
 <CAKuzo_hC11dM1t5sPY9MV1AVzXLr+ZxD+BF3EFQv4e4o87BxGg@...278...>
 <b53bcb01-6a0b-be13-c2df-0a7f7bc848b5@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b598f4ba-320b-c3bb-8189-ca013b3f1a0a@...2080...>
Date: Wed, 7 Mar 2018 13:13:12 +0100
MIME-Version: 1.0
In-Reply-To: <b53bcb01-6a0b-be13-c2df-0a7f7bc848b5@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2XGeKmPyo7wVFnFfXM5cfNuMrxCDvFFvb"
Subject: Re: [Openvpn-devel] [PATCH v2] Rework OpenVPN auth-token support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2XGeKmPyo7wVFnFfXM5cfNuMrxCDvFFvb
Content-Type: multipart/mixed; boundary="tMnzA7ngptZxhgnDuoformJNLD0b230I6";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Arne Schwabe <arne@...1227...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <b598f4ba-320b-c3bb-8189-ca013b3f1a0a@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Rework OpenVPN auth-token support
References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <1520265024-2129-1-git-send-email-arne@...1227...>
 <CAKuzo_hC11dM1t5sPY9MV1AVzXLr+ZxD+BF3EFQv4e4o87BxGg@...278...>
 <b53bcb01-6a0b-be13-c2df-0a7f7bc848b5@...1227...>
In-Reply-To: <b53bcb01-6a0b-be13-c2df-0a7f7bc848b5@...1227...>

--tMnzA7ngptZxhgnDuoformJNLD0b230I6
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 07/03/18 12:52, Arne Schwabe wrote:
>> So, failure due to token expiry that normally happens during a reneg[*]
>> will not trigger AUTH_FAILED and the client will continue trying reneg
>> until the previous TLS session expires (1 hour?). This is a
>> basic limitation of the present implementation and I do not see it
>> being addressed by the patch.
>
> I will look into sending AUTH_FAILED also without management-client-auth.

Just a quick response.  AUTH_FAILED can provide an explanation which the
client can pick up and act upon.  I did that in an earlier attempt, but it
required lots of refactoring as the send_control() function depends on a few
structs not being available where the token failures can be tackled.

See this mail thread for details:
   Message-Id: 1477918318-18561-1-git-send-email-davids@...515...
   Mail archive:
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12848.=
html>

This approach is what James initially recommended me to do, and this approa=
ch
of providing a failure message back to the client should already be support=
ed
in OpenVPN 3 and the OpenVPN Connect clients.  This messaging I believe is
already used by the Access Server and Private Tunnel.  OpenVPN 2 in client
mode, could in these cases catch this "message" and ask for user credentials
again.

In regards to having the tokens survive reconnect, I agree.  But lets try to
split this challenge into a few more minor patches.

The challenge I see with starting with a new IV_PROTO=3D3 is that this also
requires support in the OpenVPN 3 library as well.  I believe the "expiring
auth-token" feature would be better handled with proper AUTH_FAILED signall=
ing.

I'll have a closer look (hopefully) later today, just wanted to give this
quick feedback before its too late.


--=20
kind regards,

David Sommerseth
OpenVPN Inc


--tMnzA7ngptZxhgnDuoformJNLD0b230I6--

--2XGeKmPyo7wVFnFfXM5cfNuMrxCDvFFvb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJan9deAAoJEIbPlEyWcf3ypR0P/0M7Dquee4+k2A6iFewWO9nj
5cFhkgLFH6LZ+66ZwG+1YAHQlQ9usDmROIyzFVOXJfT6cJVfpXLPP7cl/l+Yvfr0
bXawT+QUBba5cRmnwAQeHC+779cvc6s3GXOwBnsrsBW209luIjZ3HXIxADdN8ldT
/awKxxgGsxHCRALw/YWdVUeM/y5rPJUwWkimlNpuOGRGw2Fty4pME20kTteR6Z34
dTKcmq82iXQvtUhsI5XD2+D5HIg1o854CQIPEUkHuzx3K9FCVoFdpARbk+L5PhFB
fORBrB4G155LjszTJnDDo1Og5au8/lBbvlzKqBu9/fAHQTv0dzqMfcrKubFysa7I
Ijw3v9ZUXeXkNA0Vj02UGhVS3SvXeh6Ai8JeJzzez8bwbCigbZI9mRGgvteuKyUP
YVToxEtdYX0iVo7BEcskB04YLQ1bd9dggHzB/lTA1vDbuhpQ7c4gaLsyHA2COV5f
fUH/wX2XFyfnGpSoC6skcadAz/nwfyGgZGzHC9rO3OkHlT3Ln0PMGAvmrB90+CAY
P5wJl11VSYXR9QDOAtawS6fwC+FS5SRpDaAsN4MehyTSJz+yP4LnLrVwuaRTfZwi
Al/QiQU7qxsZrVdmWVl1qo5m6Y2Jfhe75y9t5q9+Y6BdysrBFfQ9uJ34H/spuLvy
4cCUS6325VApTFxJyLh8
=z3HX
-----END PGP SIGNATURE-----

--2XGeKmPyo7wVFnFfXM5cfNuMrxCDvFFvb--

