MIME-Version: 1.0
References: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>
 <d34d5974-30ac-6949-9be4-7f4a55126564@...515...>
 <bf866bdc-4be0-fea9-92d1-61d27ce7ecda@...277...>
 <df929876-8c63-0934-02f6-4ac7186d986e@...515...>
 <e4b61969-aac3-a5cd-6642-b65e3a9f0256@...277...>
 <7d23f054-2ab4-d6f2-77b0-5cb76c2ec2df@...515...>
 <AD1D828E-B77F-4D08-BB7E-722AE9545CA1@...2293...>
 <6b2de5c1-99b7-406f-04d5-bb9449d120b9@...277...>
 <1b342791-a3ba-9932-dc02-a616f86c3e17@...515...>
 <CAC6SzHLVL4d-PVA6NBSHL4xyoo=4pVPrrAHZqKWTFkjxa3UEug@...278...>
 <8i52hb.q0k274.rtj366-qmf@...2533...>
 <CAC6SzH+tWMmEC-n0s+p6ooukjBeqOifrD5uWF0B2gz7qe187Zw@...278...>
 <f4c7d7fc-f757-9f13-56fc-93a3145da4c4@...515...>
In-Reply-To: <f4c7d7fc-f757-9f13-56fc-93a3145da4c4@...515...>
From: d tbsky <tbskyd@...277...>
Date: Mon, 11 Nov 2019 10:41:19 +0800
Message-ID: <CAC6SzHKphejoK5ysyTTBEgWnSxaO36VVEZmSqh015A-vjci5uw@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.8 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Samuli Sepp=C3=A4nen <samuli@...515...>=EF=BC=9A
> The error is pretty clear:
>
> Error 0x800b0109: A certificate chain processed, but terminated in a
> root certificate which is not trusted by the trust provider.
>
> Is your computer perhaps behind in Windows updates? My hunch is that
> Digicert's latest root certificate is not availabe in the Windows
> certificate store and this causes the failure.
>
> Samuli

   thanks for the hint! but I don't know why uninstall/reinstall make
things work?

  our windows 7 update is stay at 2019-8, which is not very far
behind. but we do security-only update to prevent telemetry, I don't
know if that make difference.
  I will try again when windows update mess quiet down. December patch
is always good these years. hope it is the same this year.

Regards,
tbskyd

