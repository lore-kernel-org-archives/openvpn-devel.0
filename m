MIME-Version: 1.0
References: <20191213191634.250-1-lstipakov@...277...>
 <20191213191901.300-1-lstipakov@...277...>
 <CAKuzo_jNn9NG-chJHx62H2CTiB64dCrq3S3_oW7oR8Tngf4F9w@...278...>
 <CAGyAFMVReSwJsYAKo5S4pV4POV31g0roxz4P2Ajvr+8hoEYbeA@...278...>
 <CAKuzo_hMws66xJsN69qa6WmgXNdrSKioHQrpE9VZ89-J2O7+KA@...278...>
 <162696E1-8F58-4B9A-A591-2622E3ADE746@...2293...>
 <CAKuzo_jFzECCsOk=OvrN0+S0dx4WmGOm7qL8L2sGYUTRd+qxXw@...278...>
 <99D61A626FDA8A4B90A270669121BE10D05C6ECC@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10D05C6ECC@...2294...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 17 Dec 2019 10:15:28 -0500
Message-ID: <CAKuzo_i1h4GyJkAthBG9BMX+ywfHtuO6vnPkyMReqAkBLPbYmw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v6 4/7] wintun: ring buffers based I/O
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
To: Simon Rozman <simon@...2293...>
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Tue, Dec 17, 2019 at 6:09 AM Simon Rozman <simon@...2293...> wrote:
>
> I have been playing with Lev's patches for the past few days. Tested them=
, debugged them, did some fixes. There are things to be desired like netsh=
=3D>ipcfg, remove or #ifdef the SYSTEM token hack... But those are design c=
hoices we should pursue in the future. I believe patches are mature enough =
to ack them. They should be merged into master to provide wider testing and=
 easier development progress.

I agree. And, if we wont release official binaries with the system
hack, the patch looks good to me too.

Selva

