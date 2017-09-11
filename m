References: <CAFHpkQGG9x_kYP6bthSxgB+1Y38r45ffD1WCnaA+Jp4Ed8PbQw@...278...>
 <cf0cbe5b-238c-8790-5be1-3cb693ac4148@...1147...>
 <CAFHpkQGu93WJEhFMyA1y4RFdL9bJJijdMrQWOMdHt+DU1iVO-g@...278...>
 <CAFHpkQEZDWqMbwU07LGtLVXyN2_VGz3v8jHZdwRAfGg07Jw3wA@...278...>
 <c0d738c1-2f62-3746-21cd-e451a3d90824@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b2cacf07-a4ac-2f4e-9ae5-12b55f4a063a@...1227...>
Date: Mon, 11 Sep 2017 14:52:51 +0200
MIME-Version: 1.0
In-Reply-To: <c0d738c1-2f62-3746-21cd-e451a3d90824@...2080...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] proper configuring of "tls-verify"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn@...2080...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>

Am 11.09.17 um 14:30 schrieb David Sommerseth:
> On 11/09/17 14:02, Илья Шипицин wrote:
>>
>>
>> 2017-09-11 16:54 GMT+05:00 Илья Шипицин <chipitsine@...277...
>> <mailto:chipitsine@...277...>>:
>>
>>
>>
>>     2017-09-11 16:45 GMT+05:00 Jan Just Keijser <janjust@...1147...
>>     <mailto:janjust@...1147...>>:
>>
>>         Hi,
>>
>>         On 11/09/17 13:22, Илья Шипицин wrote:
>>
>>             Hello,
>>
>>             is someone actually using "tls-verify" in production ?
>>             we tried to implement additional certificate check using
>>             tls-verify
>>
>>
>>             while it works in general, in case when it hits "exit 1", it
>>             look like a timeout from client point of view. it is not any
>>             good
>>
>>
>>         do you mean that when a client is denied access (i.e. the
>>         tls-verify script exits 1 on the server) that the client sees
>>         this as a timeout?  that is "normal" behaviour, as the server
>>         does not tell the client *WHY* access is refused - it simply
>>         stop responding to a client that does not pass
>>         authentication/authorization. The client will not hear from the
>>         server, and will time out after a specified interval.  This is
>>         actually the most secure way to do things, as a rogue client
>>         cannot DoS a server this way.
>>
>>
>>     I'd say it depends.
>>
>>     we run a lot of openvpn-gui with real people sitting in front of
>>     them, from their point of view it "oh, it does not work! fix it!"
>>     in out case better UX is to deliver proper reason to the client
>>
>>     for someone maybe the better UX is to keep silence
>>
>>
>>
>> what is wrong with timeout is endless retry.
>> there's no way to pass authentication once it failed, so why does client
>> have to retry ?
> 
> User-friendliness and security seldom walks hand-in-hand.  As this
> friendliness provides enough information fragments for an attacker to
> figure out "I need to try something else".  A non-responding server
> gives no clues.  It can be a crappy server or it can be access denied;
> the attacker doesn't know - thus making it harder to figure out what to
> do next.
> 
> The client will by default try to reconnect, because that is what it in
> most cases is told to do when the server is unresponsive.  And since
> this happens with many seconds in between, a single client will not
> attempt to DoS a server by mistake by retrying in a too tight loop.
> 
> A failed authentication is a failed authentication.  Thus UX client
> front-ends could treat this silence like that - but also account for
> other types of connectivity issues.  If it should try to reconnect or
> not, well, that's entirely up to the configuration file.   There is
> --single-session which can be used to control this.
> 
> But for servers running OpenVPN clients, retrying indefinitely at
> regular intervals may just as well be valuable; if it is an issue which
> is temporary.  Then these clients would reconnect once everything is
> back online again on the server side.
> 


Also you can limit the number of unsucessfull retries in OpenVPN with
the connnect-retry option.

Arne

