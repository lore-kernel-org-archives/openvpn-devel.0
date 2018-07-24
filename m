MIME-Version: 1.0
In-Reply-To: <CAKuzo_hQGh6j5BJCv4whVOkJOgikUSuw5wAtmcQBWtsJ0QsUNg@...278...>
References: <CAEsd45Rd+5_NTeQ_E1C9wps89GWU6OfxQ5CdEFiN_HCO0=xaAQ@...278...>
 <CAKuzo_in_bBm1Y1rwU3rhFfuUP8o7j9iQH9vyjk9myT42tpBSg@...278...>
 <CAEsd45Tqb4nCQYe9_CKwr6YKdW4BoF3B-V=iQU=KXPnYDu8GJQ@...278...>
 <CAKuzo_hhoa_3xs0NSt7A7o-9WErqZEp+uvGv2XQi0FmJ10H9jw@...278...>
 <CAEsd45STfqNvTKFTcpJ8nsy0nfndfQHJ7dTD8iSRJFGQ5aE3Hg@...278...>
 <20180719175253.GZ55859@...1296...>
 <CAKuzo_gYBnZrwQtvC5jx_JsnL13eimr9wRxSVYezsVONKiB9wA@...278...>
 <20180719191455.GB55859@...1296...>
 <CAKuzo_hQGh6j5BJCv4whVOkJOgikUSuw5wAtmcQBWtsJ0QsUNg@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 23 Jul 2018 22:58:21 -0400
Message-ID: <CAEsd45T9Zii=RWy9kMu=dYhksjEfruQhQ3uzVie_GMCnmPcmsg@...278...>
Subject: Re: [Openvpn-devel] Dynamic challenge/response questions
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
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

I was testing Tunnelblick with Selva's C/R server and config (thanks
again for that) and there was a problem. Maybe I'm (still)
misunderstanding something, but a SIGUSR1 restart asks for the normal
username/password instead of a static C/R.

That is, the first thing after the restart is ">PASSWORD:Need 'Auth'
username/password" instead of ">PASSWORD:Need 'Auth' username/password
SC:1,Type something (e.g., hello): ".

Should Tunnelblick save the static challenge info (like it saves the
dynamic challenge info) and use it again whenever it sees a
">PASSWORD:Need 'Auth' username/password"? (Except when there is also
a pending dynamic challenge, in which case it would use that instead.)

Also, there's an oddity (that doesn't cause a problem) in that the
first thing Tunnelblick sees over the management interface for the
original connection is "ENTER PASSWORD:SUCCESS: password is correct"
-- that comes even before ">INFO:OpenVPN Management Interface Version
1 -- type 'help' for more info", and long before any username or
password has been entered.

Once I get everything working (and I understand it myself), I plan to
submit a patch to doc/management-notes.txt that will (I hope) clarify
the C/R documentation.

Thanks,

Jon

On Thu, Jul 19, 2018 at 4:22 PM, Selva Nair <selva.nair@...277...> wrote:
> Hi,
>
> Here is the config. There are no secrets, so just input anything
> against the username/password/static challenge prompts (use short
> non-empty strings). For dynamic challenge, the answer must be correct
> for the connection to succeed.
>
> If the server is down please ping me.
>
> Selva
>
> On Thu, Jul 19, 2018 at 3:14 PM, Gert Doering <gert@...1296...> wrote:
>> Hi,
>>
>> On Thu, Jul 19, 2018 at 02:38:55PM -0400, Selva Nair wrote:
>>> On Thu, Jul 19, 2018 at 1:52 PM, Gert Doering <gert@...1296...> wrote:
>>> > On Thu, Jul 19, 2018 at 11:43:17AM -0400, Jonathan K. Bullard wrote:
>>> >> Thank you, Selva! (Now all I need to do is get it working!)
>>> >
>>> > Looking very much forward to see this happen :-)
>>> >
>>> > ($payingCustomer )
>>>
>>> Send some ??????/$$ from $payingCustomer this way :)
>>
>> I might elicit some funding for Beer at the Hackathon... *tempt*
>>
>> (They do already sponsor our fun - all my buildslaves run on their vmware
>> farm and eat their bandwith... :-) - just no direct flow of money)
>>
>>> Jon: I have a server for testing static and dynamic challenge. If
>>> interested I can send you a config. Or use access server with a free
>>> test license. Mine will just challenge with 1 + 1 = ? kind of
>>> questions, nothing fancy.
>>
>> Interest!  (Though I might actually have the config already, just
>> never came around to work on it)
>>
>> gert
>> --
>> "If was one thing all people took for granted, was conviction that if you
>>  feed honest figures into a computer, honest figures come out. Never doubted
>>  it myself till I met a computer with a sense of humor."
>>                              Robert A. Heinlein, The Moon is a Harsh Mistress
>>
>> Gert Doering - Munich, Germany                             gert@...1296...

