From: Selva Nair <selva.nair@...277...>
Date: Wed, 11 Nov 2015 14:46:10 -0500
Message-Id: <1447271171-29141-1-git-send-email-selva.nair@...277...>
In-Reply-To: <CAKuzo_i7tOuGT87h2wQmCG1ivx9NDB5K0J8Z0sXxzTKO-oMHxw@...278...>
References: <CAKuzo_i7tOuGT87h2wQmCG1ivx9NDB5K0J8Z0sXxzTKO-oMHxw@...278...>
Subject: [Openvpn-devel] [PATCH] Handle ctrl-C and ctrl-break events on
	Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Mon, Nov 9, 2015 at 2:03 PM, Selva Nair <selva.nair@...277...> wrote:
>> It's probably okay to just make CTRL-c generate a SIGTERM as F4 is
>> already doing.
>>
>> James
>
> Thanks for the comment.
>
> In the interactive mode, the console is opened with no
> ENABLE_PROCESSED_INPUT so ctrl-C will be delivered as key-board input
> and could be handled just like F4.
>
> With nssm, the console is shared with nssm, so ctrl-C is delivered as
> a signal. I'll send a patch handling both cases.

The patch is in the next email. 

Handling the key-board input is easy, but making the callback interrupt the event loop
looks tricky. I am not well versed with the event handling in the code, so 
opted to generate a key-pressed event. If there is a better way please suggest.

Simply calling throw_signal in the callback will work, but could take several seconds
before its noticed.

Tested on windows 7 with cmd-line use and start/stop with nssm. For nssm, the default 
delay after ctrl-C is 1500 msec which is not enough for the process to exit if exit-notify
is being used. About 1 second per extit notify trials + an extra 1 second is suggested. 

 src/openvpn/win32.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

-- 
2.6.2


