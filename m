From: Kristof Provost <kp@...1376...>
Date: Thu, 08 Jun 2023 22:29:34 +0200
Message-ID: <A55BB037-2A50-42CC-9B54-8C3DEAF604E9@...1376...>
In-Reply-To: <ZIIxis5u5JG3Zzj0@...1296...>
References: <20230414094227.9153-1-kprovost@...2661...>
 <202305081155.348BtYlh004143@...2054...>
 <20D50979-90A2-45C2-9C10-FDD8E0CDC803@...1376...>
 <ZIIxis5u5JG3Zzj0@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH applied] DCO: support key rotation
 notifications
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 8 Jun 2023, at 21:52, Gert Doering wrote:
> Hi,
>
> On Mon, May 08, 2023 at 06:15:52PM +0200, Kristof Provost wrote:
>> I???ve also landed the (FreeBSD) kernel side of that: https://cgit.freeb=
sd.org/src/commit/?id=3Df7ee28e755820375d5f441e19c1f1376a200e834
>
> I now had (finally) time to test this.
>
>  - Upgraded FreeBSD current to "as of today"
>  - modified the kernel to set OVPN_SEQ_ROTATE to "10000" and added
>    a printf() call (to make this easier to observe)
>  - pinged!
>
> -> and it works nicely, every 10.000 packets, I see my kernel printf()
>
=E2=80=A6
>
> Good work, folks :-)
>
Thanks.

I=E2=80=99d tell you off for doubting me, but the first thought in my head =
when I saw this e-mail was =E2=80=9COh no, what did I break?=E2=80=9D, so I=
=E2=80=99m going to let it go this time :)

Best regards,
Kristof

