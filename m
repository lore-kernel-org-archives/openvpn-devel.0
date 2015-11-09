References: <CAKuzo_hsHus7dgLMi8D=SzQn4f+2GNQJjx8HACvD3xmsD=Ux5w@...278...>
	<56404D65.1030704@...515...>
From: James Yonan <james@...515...>
Message-ID: <5640E018.8030306@...515...>
Date: Mon, 9 Nov 2015 11:04:08 -0700
MIME-Version: 1.0
In-Reply-To: <56404D65.1030704@...515...>
Subject: Re: [Openvpn-devel] Adding a ctrl-C handler in windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On 09/11/2015 00:38, Samuli Sepp=E4nen wrote:
>
>> Hi,
>>
>> I plan to add a control-C handler in win32.c. The handler will simply
>> map it to SIGTERM. Is there any particular reason why control-C is not
>> currently handled?
>
> Hi,
>
> I forwarded this email to James - he might have a clue.

Currently the Windows implementation, when running in console mode, uses=20
function keys to trigger various Unix signals (see win32_signal_get()=20
function in win32.c).

The current code looks like this:

   switch (win32_keyboard_get (ws))
     {
     case 0x3B: /* F1 -> USR1 */
       ret =3D SIGUSR1;
       break;
     case 0x3C: /* F2 -> USR2 */
       ret =3D SIGUSR2;
       break;
     case 0x3D: /* F3 -> HUP */
       ret =3D SIGHUP;
       break;
     case 0x3E: /* F4 -> TERM */
       ret =3D SIGTERM;
       break;
     }


It's probably okay to just make CTRL-c generate a SIGTERM as F4 is=20
already doing.

James

