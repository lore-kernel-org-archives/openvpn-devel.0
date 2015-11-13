MIME-Version: 1.0
In-Reply-To: <20151113193620.GW24952@...1296...>
References: <CAKuzo_i7tOuGT87h2wQmCG1ivx9NDB5K0J8Z0sXxzTKO-oMHxw@...278...>
	<1447271171-29141-1-git-send-email-selva.nair@...277...>
	<20151113193620.GW24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 13 Nov 2015 15:19:38 -0500
Message-ID: <CAKuzo_iX9Qgkp7jvHvRGWX=FBGa56XOTEZ-hr9t6NCzQQx-jpA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Handle ctrl-C and ctrl-break events on
	Windows
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Fri, Nov 13, 2015 at 2:36 PM, Gert Doering <gert@...1296...> wrote:
> On Wed, Nov 11, 2015 at 02:46:10PM -0500, Selva Nair wrote:
> [..]
>> Tested on windows 7 with cmd-line use and start/stop with nssm. For nssm, the default
>> delay after ctrl-C is 1500 msec which is not enough for the process to exit if exit-notify
>> is being used. About 1 second per extit notify trials + an extra 1 second is suggested.
>
> So this would be something for Samuli to adjust when setting up NSSM?  Like,
> 2500 ms?

That is correct. It could be added to the nssm info page that Samuli
maintains. I use 3000 msec with "--explicit-exit-notify 2" and works well.

Selva

