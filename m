MIME-Version: 1.0
In-Reply-To: <105ebedf-0cfd-b8db-d18a-35d67090f002@...2080...>
References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <1520265024-2129-1-git-send-email-arne@...1227...>
 <68b5e196-ee80-7975-4a29-161d71521ec4@...2080...>
 <CAKuzo_h8CnAZEm920WYw8_KUr76h1rzhj_c6FcxR=BYeQfj2wA@...278...>
 <105ebedf-0cfd-b8db-d18a-35d67090f002@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 7 Mar 2018 19:25:38 -0500
Message-ID: <CAKuzo_gLt6iS8ip20E=j3pzpTspV4tu=ictJgr9e94p8dQecGw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Rework OpenVPN auth-token support
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Mar 7, 2018 at 6:52 PM, David Sommerseth
<openvpn@...2080...> wrote:
> On 08/03/18 00:22, Selva Nair wrote:
>> Hi,
>>
>> ...some good stuff snipped...
>>
>>>
>>> I'll admit I might see this with a bit too narrow perspective.  But how I have
>>> understood this issue is that OpenVPN 2.x does not behave correctly as it
>>> doesn't understand *why* the authentication failed.  If the client side would
>>> understand why auth failed, then it can query the user for credentials again -
>>> which I believe should resolve the current issues ... Or have I missed something?
>>
>> I hope we are slowly spiralling towards a solution; not going around
>> in circles...
>>
>> Anyway, to reiterate: we currently have two issues. (i) client is not
>> told when authentication fails during reneg
>> and (ii) client doesn't know that auth-gen-token's token is not
>> reusable across reconnects
>> (SIGHUP and SIGUSR1).
>
> Okay, (i) is handled with AUTH_FAILED,SESSION messages today in OpenVPN 3.
> OpenVPN 2 should be taught to do the same - both server and client side.
>
> In regards to (ii), that is an implementation detail which I would say is
> incorrect with --auth-gen-token.  As I am the one who implemented that
> feature, I would rather have this fixed so auth-gen-token works across restarts.
>

Well, IMO, fixing (i) is more important than (ii). It would also make it
easy to add support for dynamic auth through scripts and plugin,
for example. Currently not possible because a specially crafted
"reason" for AUTH_FAILED cannot be sent back unless
management-client-auth is used. Unrelated to auth-token but a sorely
missing feature. That said, personally I prefer management-client-auth
to using scripts and the former works fine as is.

Regarding (ii), reusing auth-token across SIGHUP and SIGUSR1
reconnects could have security implications. At the minimum we should
treat auth-token as a high value asset on the client side and not send
it to management (at least on the Windows GUI it currently shows up in
plain text in the status log). In the current state of things, the
client-side management has no use for the actual value of the token as
it cant override the client daemon's handling of it.

Selva

