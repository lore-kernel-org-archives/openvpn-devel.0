References: <20170906235202.26551-1-davids@...515...>
 <45ee0784-77cf-bba1-85cf-f7c6265b25f5@...277...>
 <41cf1b9e-bb4b-a2f1-3c3a-cde43c8e0eb4@...2080...>
 <84bc7ec5-886e-7ae6-87a7-0385d0506376@...277...>
 <8c9c7f22-30a6-a192-f56d-961605a6d1c2@...2080...>
From: fragmentux <fragmentux@...277...>
Message-ID: <8aaacc62-7c5f-14d0-e1a4-a38b89c90625@...277...>
Date: Fri, 8 Sep 2017 01:22:26 +0100
MIME-Version: 1.0
In-Reply-To: <8c9c7f22-30a6-a192-f56d-961605a6d1c2@...2080...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 07/09/17 23:55, David Sommerseth wrote:
> On 07/09/17 23:02, fragmentux wrote:
> i,
>>
>> all your comment are totally valid from a sys-admin point of view but
>> from an openvpn POV, the only responsibility is to provide a secure VPN.
>>
>> Use all of systemd's functions to maximize openvpn's process *security*
>> But *forcing* restart as an almost unconditional default is nonsense.
> 
> We are in the position to promote sane and good defaults.  This
> behaviour is considered sane and good by many sys-admins.  So when these
> two view-points intersects, I see no harm of us actually promoting this
> change.

Do you want to discuss the "sanity" of said sys-admins ?

I do not subscribe to "popular POV" .: I disagree with your sys-admins.
I believe the restart decision should remain in the hands of the owner.


>> How would you do this for non-systemd systems ?
> 
> Isn't that obvious?  systemd unit files are for systemd.  Non-systemd
> systems doesn't have systemd unit files, thus there is very little we
> can do about them.

Consistent behaviour is clearly *not* your primary concern for OpenVPN.
^Take Note^

>> I disagree with making this change to the default
>> openvpn-server@...1685... unit file.
> 
> Your opposition have been noted.

Yeah right ..


>> If you really want to include them then how about:
>>
>> Either:
>>    openvpn-server@...1685... (responsible for start/stop etc actions)
>>    openvpn-server-auto-restart@...1685... (speaks for itself)
> 
> NAK.  This is not how the design around systemd unit files is intended
> to be used.  
"design around systemd" .. Not OpenVPN

So what does Mr. https://github.com/poettering recommend ?

I prefer my "broken" servers to Fail outright
regardless of what Pot. or you think.


 > Plus: it already exists a Debian bug ticket where there are
 > comments about us adding 2 more unit files.  If adding even more, I can
 > already sense the heat increasing on that ticket.

Thus .. see Next

>> Or rather
>>    include extra .service files in ./contrib. as samples or such.
> 
> NAK.  I rather have a document 

Another badly (if at all) maintained OpenVPN document ..

and lets face facts here .. this is *systemd* not "$(I deleted what I 
wanted to say .. maybe you can guess)" or some such.


> simply describing how to change the
> defaults using 'systemctl edit'.  Which is exactly how systemd is
> designed to be used.  But we should have a baseline of recommended
> defaults, and sys-admins can choose to opt-out of these defaults through
> standard mechanisms, not by adding complexity through more unit files to
> scan through.
> 

Auto Restart on Failure for OpenVPN is *not* a recommended default
other than by you and I stand against it.


> Just image a system 

Must I  .... ?  To what `end` .... ?

> which actively uses both openvpn-server@ and
> openvpn-server-autorestart@...220...  Unless we also split up
> /etc/openvpn/server ... it will be even more confusing when
> investigating a server in 2 years why something is misbehaving.  "Did
> this config run through this or that unit file?".  openvpn-server@ is
> clear and specific, it handles server configurations.  Period.

Thus it should *not* be the decision of an openvpn developer to decide
if "somebody else's" server should behave like yours ..
IE: Forced Restart .. By default.

*NAK*


> If you want a specific configuration or all openvpn-server@ OpenVPN
> configurations to behave differently from the recommended defaults, then
> you do that through 'systemctl edit', where it is very visible if this
> specific configuration have some additional tweaks not - through

I know enough about systemd thanks.

I reject the idea that *all* servers under the control of /systemd/
should _inherit_ an almost forced restart due to *your* preference.


> 'systemctl status'.  This way sys-admins won't have remember or research
> which 'sub-unit file' of openvpn-server@ to achieve a specific behaviour.

"sys-admins won't have to remember" .. word fail me.

People have a job to do ..


My final note:

1. As soon as I read this patch I was against it ..
2. I understand that I am not the most educated of Linux users
3. This "patch" has nothing to to with the function of OpenVPN
    therefore it should remain that way.

regards,

