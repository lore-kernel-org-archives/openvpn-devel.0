References: <20190510121114.30468-1-arne@...1227...>
 <9b117603-189a-b5da-b3e4-c7f22c7bc363@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ba6ea39f-3217-6e44-2294-15f391d12860@...1227...>
Date: Thu, 13 Jun 2019 15:24:53 +0200
MIME-Version: 1.0
In-Reply-To: <9b117603-189a-b5da-b3e4-c7f22c7bc363@...2080...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v3 0/7] Auth token patches v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn@...2080...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> * The --help screen is inaccurate in regards to --auth-gen-token and --genkey
>   entries.
> 
> * Using --genkey with --secret now sends the key to stdout instead of the
>   given --secret file.  I don't recall if we discussed this and if this was
>   considered expected.

These two will be fixed in a version of the --genkey patch.
> 
> * When starting a server with --auth-gen-token-secret, there is no (afaict)
>   indications in the log file such a file is used

No. But there is a warning when not using that file and an ephermal key.

> 
> * In the log file when the server sends PUSH_REPLY there's a formatting issue,
>   where you will find: [...], auth-tokenSESS_ID,[....].  This happens on both
>   server and client.
> 
> * The configuration below ends up going into username/password auth loop on
>   each renegotiation after the auth-token has expired:

>    What happens:
>    - Server starts
>    - Client starts and connects, auth with username/password (state: Initial)
>    - 30 seconds, reneg happens
>    - Client re-auth with token (state: Authenticated)
>    - 30 seconds, reneg happens
>    - Client re-auth with token (state: Expired)
>    - 30 seconds, reneg happens
>    - Client re-auth with token (state: Expired)
>    - Client restarts with username/password auth (state: Initial)

Up to here that is more or less expected behaviour. (The renog failing
and connnection continuing to work until renog timeout is reached, is
wonky but will/should also happen with other auth methods)

>    - 30 seconds, reneg happens
>    - Client restarts with username/password auth (state: Initial)

So here it looks like the client did not get a new auth-token or ingored
it right?
>    - 30 seconds, reneg happens
>    - Client restarts with username/password auth (state: Initial)
>    ....
> 
This might be a problem of auth-nocache on the client side doing strage
things. I never had that on.

Arne

