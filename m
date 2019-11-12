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
 <CAC6SzHKphejoK5ysyTTBEgWnSxaO36VVEZmSqh015A-vjci5uw@...278...>
 <99D61A626FDA8A4B90A270669121BE10C9A6C154@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10C9A6C154@...2294...>
From: d tbsky <tbskyd@...277...>
Date: Tue, 12 Nov 2019 13:44:27 +0800
Message-ID: <CAC6SzH+G-u+cAuDtu=fpn_SANMV=AiPUOjK2N8hp-C5q73hyhA@...278...>
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
Content-Transfer-Encoding: 8bit
To: Simon Rozman <simon@...2293...>
Cc: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Simon Rozman <simon@...2293...>
> The TAP-Windows6 driver remains loaded when there are TAP adapters present.
> Even if adapters are in the "disconnected" state. This makes upgrading the
> driver a real challenge. I would suggest disabling all TAP adapters before
> attempting the upgrade. Disabling the last of the TAP adapters will cause
> Windows kernel to unload the TAP-Windows6, allowing its upgrade.

     try to disable TAP Adapter and upgrade. there is no more error
during installation. but when I try to connect it shows the tap device
is in use. reboot is useless.
if I uninstall tap-windows 9.21 first and then upgrade, everything
works fine even without reboot.

    we don't have KB2921916 installed and we use correct win7 installer.

Regards,
tbskyd

