MIME-Version: 1.0
In-Reply-To: <5640E018.8030306@...515...>
References: <CAKuzo_hsHus7dgLMi8D=SzQn4f+2GNQJjx8HACvD3xmsD=Ux5w@...278...>
	<56404D65.1030704@...515...> <5640E018.8030306@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 9 Nov 2015 14:03:48 -0500
Message-ID: <CAKuzo_i7tOuGT87h2wQmCG1ivx9NDB5K0J8Z0sXxzTKO-oMHxw@...278...>
Subject: Re: [Openvpn-devel] Adding a ctrl-C handler in windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: James Yonan <james@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Nov 9, 2015 at 1:04 PM, James Yonan <james@...515...> wrote:
>>> I plan to add a control-C handler in win32.c. The handler will simply
>>> map it to SIGTERM. Is there any particular reason why control-C is not
>>> currently handled?
>>
>> Hi,
>>
>> I forwarded this email to James - he might have a clue.
>
> Currently the Windows implementation, when running in console mode, uses
> function keys to trigger various Unix signals (see win32_signal_get()
> function in win32.c).
>
> The current code looks like this:
>
>    switch (win32_keyboard_get (ws))
>      {
>      case 0x3B: /* F1 -> USR1 */
>        ret = SIGUSR1;
>        break;
>      case 0x3C: /* F2 -> USR2 */
>        ret = SIGUSR2;
>        break;
>      case 0x3D: /* F3 -> HUP */
>        ret = SIGHUP;
>        break;
>      case 0x3E: /* F4 -> TERM */
>        ret = SIGTERM;
>        break;
>      }
>
>
> It's probably okay to just make CTRL-c generate a SIGTERM as F4 is
> already doing.
>
> James

Thanks for the comment.

In the interactive mode, the console is opened with no
ENABLE_PROCESSED_INPUT so ctrl-C will be delivered as key-board input
and could be handled just like F4.

With nssm, the console is shared with nssm, so ctrl-C is delivered as
a signal. I'll send a patch handling both cases.

Selva

