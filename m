MIME-Version: 1.0
In-Reply-To: <CAP+U6t+djWatsor=OoKuSLEC12Mt5Vin8hJu2S81aRcAtPjk5Q@...278...>
References: <CAGyAFMWg5j+ki56=fwOOZwcpAdixE8eDyJXFgktrNsOqrYZRcA@...278...>
	<CAP+U6tKkiU3FmaPN66s62iZiEoqbmgLjn4J-kJTM9P=0H5qSMg@...278...>
	<CAGyAFMX8Hf81e5Jom-F4__7ktrA5pyf1ygMff2ixHzqhsTebGQ@...278...>
	<CAP+U6t+djWatsor=OoKuSLEC12Mt5Vin8hJu2S81aRcAtPjk5Q@...278...>
Date: Mon, 13 Oct 2014 09:59:24 +0300
Message-ID: <CAGyAFMWg32tGHEBair6dXvz=rUxN_=8Ou4whd5bjBKyuNTJquA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Subject: Re: [Openvpn-devel] Async OPENVPN_PLUGIN_CLIENT_CONNECT plugin
	support
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
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Fabian,

> You say that you've added support for the client-connect plugin call. May I
> ask what was missing?

Nothing dramatic, I just added deferred support for client-connect v2.

> So this is basically about replacing a 5s poll-interval with something that
> should proceed near instantaneously, correct?

Well, 5 seconds interval is still there, it is client-side thing. I
made server send
push_reply immediately after result is ready (written to ccr file)
without waiting
for incoming push_request.

I noticed that if authentication / authorization happens fast enough, server may
send push_reply before push_request is arrived. Sometimes client anyway sends
push_request and server sends second push_reply. To avoid that and to follow
the protocol (I haven't noticed any issues, though), in latest version
I made server wait
for the first push_request. So, if authorization takes less than
second, client will get response
in a second (with first push_request), otherwise immediately when auth is done.

I can probably modify client part and make it not send push_request if
push_reply
has already arrived. Would it be the correct way?

> Thanks for sharing! I'll have a look at it, when time permits. Though my
> focus is currently on getting some or all of the patches from the basic
> patch-set upstream.

Indeed it would be great to have your patch in upstream master.

-Lev

