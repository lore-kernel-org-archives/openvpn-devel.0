MIME-Version: 1.0
In-Reply-To: <CAKuzo_gCLjTMyK7jnrods51SeRDgExWG4nwQOKSjNgPwjFcndw@...278...>
References: <CAEsd45Rd+5_NTeQ_E1C9wps89GWU6OfxQ5CdEFiN_HCO0=xaAQ@...278...>
 <CAKuzo_in_bBm1Y1rwU3rhFfuUP8o7j9iQH9vyjk9myT42tpBSg@...278...>
 <CAEsd45Tqb4nCQYe9_CKwr6YKdW4BoF3B-V=iQU=KXPnYDu8GJQ@...278...>
 <CAKuzo_hhoa_3xs0NSt7A7o-9WErqZEp+uvGv2XQi0FmJ10H9jw@...278...>
 <CAEsd45STfqNvTKFTcpJ8nsy0nfndfQHJ7dTD8iSRJFGQ5aE3Hg@...278...>
 <20180719175253.GZ55859@...1296...>
 <CAKuzo_gYBnZrwQtvC5jx_JsnL13eimr9wRxSVYezsVONKiB9wA@...278...>
 <20180719191455.GB55859@...1296...>
 <CAKuzo_hQGh6j5BJCv4whVOkJOgikUSuw5wAtmcQBWtsJ0QsUNg@...278...>
 <CAEsd45T9Zii=RWy9kMu=dYhksjEfruQhQ3uzVie_GMCnmPcmsg@...278...>
 <CAKuzo_gCLjTMyK7jnrods51SeRDgExWG4nwQOKSjNgPwjFcndw@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Tue, 24 Jul 2018 06:53:27 -0400
Message-ID: <CAEsd45To36w6ihTQWBHgwT6J82EksvqK7kyDb+LFpr8V5kVmsg@...278...>
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

Hi,

On Tue, Jul 24, 2018 at 12:02 AM, Selva Nair <selva.nair@...277...> wrote:
> Hi,
>
> On Mon, Jul 23, 2018 at 10:58 PM, Jonathan K. Bullard
> <jkbullard@...277...> wrote:
>> I was testing Tunnelblick with Selva's C/R server and config (thanks
>> again for that) and there was a problem. Maybe I'm (still)
>> misunderstanding something, but a SIGUSR1 restart asks for the normal
>> username/password instead of a static C/R.
>>
>> That is, the first thing after the restart is ">PASSWORD:Need 'Auth'
>> username/password" instead of ">PASSWORD:Need 'Auth' username/password
>> SC:1,Type something (e.g., hello): ".
>
> I think that's a side effect of my test config using both static challenge and
> dynamic challenge together. Not a realistic use case, I suppose. I did
> that to keep
> the server side verify simple for a quick validation of patches that
> touch user-auth.

OK; makes sense.


> But it was probably not a good approach for properly testing what happens on
> signals or during TLS renegotiation.

I was testing more than the test was designed to do, so that's understandable.


> If you wish I can amend my server side verify script so that you can test
> static and dynamic challenge each separately.

That would be great, but don't do it just for me. If you do it for
yourself, let me know, though, and I'll try it.


>> Should Tunnelblick save the static challenge info (like it saves the
>> dynamic challenge info) and use it again whenever it sees a
>> ">PASSWORD:Need 'Auth' username/password"? (Except when there is also
>> a pending dynamic challenge, in which case it would use that instead.)

(I tried doing that and all worked well, so I was thinking that was it.)


> Normally SIGUSR1 restart should re-prompt with the static challenge if in use.

OK, thanks. I won't commit the code that saves and reuses the static C/R info.


>> Also, there's an oddity (that doesn't cause a problem) in that the
>> first thing Tunnelblick sees over the management interface for the
>> original connection is "ENTER PASSWORD:SUCCESS: password is correct"
>> -- that comes even before ">INFO:OpenVPN Management Interface Version
>> 1 -- type 'help' for more info", and long before any username or
>> password has been entered.
>
> The ENTER PASSWORD: is for the management-password, isn't it?

Of course it is. Mystery solved, thanks!


Best regards,

Jon

