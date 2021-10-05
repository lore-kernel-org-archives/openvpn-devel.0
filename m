MIME-Version: 1.0
References: <20210825040122.14244-1-selva.nair@...277...>
 <20210825210232.22509-1-selva.nair@...277...>
 <20210825210232.22509-2-selva.nair@...277...>
 <CAKuzo_gRwdJorW-Z6rndVJcTmAsgLUcZiE9cDwoDxZULy3W4bw@...278...>
In-Reply-To: <CAKuzo_gRwdJorW-Z6rndVJcTmAsgLUcZiE9cDwoDxZULy3W4bw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 5 Oct 2021 13:13:01 -0400
Message-ID: <CAKuzo_gH9sdEUw88Mhg66trsQBWyb7oP82Hjyf4H+HaNs57hPg@...278...>
Content-Type: multipart/alternative; boundary="000000000000ae730005cd9e2f63"
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] Permit unlimited connection
 entries and remotes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000ae730005cd9e2f63
Content-Type: text/plain; charset="UTF-8"

Hi,

As this patch set is not getting any attention, I guess the need for this
is not clear enough from the commit messages. To be blunt,
--management-query-remote is pretty useless the way it stands. Let me
explain:

(1) It queries the user with one remote at a time taking about 1 second per
query. With 100 remotes, if the user wants to select the 100th one, a UI
has to show 100 popups and take ~100 seconds.

So one wants two things in good UI
(i) show a list of all available remotes to the user
(ii) have a way to jump to a remote that user chooses

For (i) one could scan the config and make a list but I'll come to why that
doesn't work in a minute. Consider (ii) first: we currently have an option
to skip remotes one by one or send a MOD request where the host and port
can be changed. Skipping one by one is very slow, and MOD doesn't allow
change of protocol. So, if the 100th item that user chooses is TCP and all
other 99 are UDP, we have to wait until we get prompted with the right one.
There are other reasons why MOD doesn't work but I want to keep this mail
simple.

Thus, we want a way to skip "N" remotes by one command (say skip 99, get
prompted with the 100th which we accept). One of the three patches in this
set does that.

Now back to (i) about making a list. For "SKIP N" to work, the UI and the
core must have an identical view of the list -- especially the order of
entries. If remote-random is in use, the only way to assure that is by
making the list by querying the core. Even otherwise independently parsing
the list from the config is not the right approach when identity of content
is important.

This, hopefully, justifies the patch that allows the UI to query the core
for a list of remotes and their indices.

The third patch is to relax the restriction on the number of remote entries
and connection lists. Currently it's hard coded to 64, there is no reason
why we can't allow 100 or even 1000 remote entries.

From experience, I know that patches that languish stay like that for
months if not years. Please, either review and ACK or hate it at first
sight and NAK. Or ask for clarification. A patch for the GUI is waiting for
the fate of this.

Thanks,

Selva

On Tue, Sep 7, 2021 at 6:27 PM Selva Nair <selva.nair@...277...> wrote:

> Hi,
>
> While implementing this feature in the GUI, I have come across some
> limitations of management-query-remote:
>
> (i) Using a remote selected by the user from a list requires skipping
> several remotes and accepting when the right one is reached. This is very
> slow when there are more than a dozen remote entries: about ~1 second per
> command.
>
> Solution: Extend "remote SKIP" to take an optional parameter to skip "n"
> entries by one command.
>
> Use of "remote MOD" is not useful here as it does not support change of
> protocol. It also has some "misbehaviour" due to the way resolved addresses
> are cached.
>
> (ii) remote-entry-get introduced here needs to be extended to support
> requesting multiple or all remote entries in one command.
>
> Please ignore the current version. v3 is coming.
>
> Selva
>

--000000000000ae730005cd9e2f63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>As this patch set is not getting an=
y attention, I guess the need for this is not clear enough from the commit =
messages. To be blunt, --management-query-remote is pretty useless the way =
it stands. Let me explain:</div><div><br></div><div>(1) It queries the user=
 with one remote at a time taking about 1 second per query. With 100 remote=
s, if the user wants to select the 100th one, a UI has to show 100 popups a=
nd take ~100 seconds.</div><div><br></div><div>So one wants two things in g=
ood UI=C2=A0</div><div>(i) show a list of all available remotes to the user=
</div><div>(ii) have a way to jump to a remote that user chooses=C2=A0</div=
><div><br></div><div>For (i) one could scan the config and make a list but =
I&#39;ll come to why that doesn&#39;t work in a minute. Consider (ii) first=
: we currently have an option to skip remotes one by one or send a MOD requ=
est where the host and port can be changed. Skipping one by one is very slo=
w, and MOD doesn&#39;t allow change of protocol. So, if the 100th item that=
=C2=A0user chooses is TCP and all other 99 are UDP, we have to wait until w=
e get prompted with the right one. There are other reasons why MOD doesn&#3=
9;t work but I want to keep this mail simple.</div><div><br></div><div>Thus=
, we want a way to skip &quot;N&quot; remotes by one command (say skip 99, =
get prompted=C2=A0with the 100th which we accept). One of the three patches=
 in this set does that.</div><div><br></div><div>Now back to (i) about maki=
ng a list. For &quot;SKIP N&quot; to work, the UI and the core must have an=
 identical view of the list -- especially the order of entries. If remote-r=
andom is in use, the only way to assure that is by making the list by query=
ing the core. Even otherwise independently parsing the list from the config=
 is not the right approach when identity of content is important.</div><div=
><br></div><div>This, hopefully, justifies the patch that allows=C2=A0the U=
I to query the core for a list of remotes and their indices.</div><div><br>=
</div><div>The third patch is to relax the restriction on the number of rem=
ote entries and connection lists. Currently it&#39;s hard coded to 64, ther=
e is no reason why we can&#39;t allow 100 or even 1000 remote entries.</div=
><div><br></div><div>From experience, I know that patches that languish sta=
y like that for months if not years. Please, either review and ACK or hate =
it at first sight and NAK. Or ask for clarification. A patch for the GUI is=
 waiting for the fate of this.</div><div><br></div><div>Thanks,</div><div><=
br>Selva</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Sep 7, 2021 at 6:27 PM Selva Nair &lt;<a href=3D"ma=
ilto:selva.nair@...277...">selva.nair@...277...</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D=
"ltr">Hi,</div><div dir=3D"ltr"><br></div><div>While implementing this feat=
ure in the GUI, I have come across some limitations of management-query-rem=
ote:</div><div><br></div><div>(i) Using a remote selected by the user from =
a list requires skipping several remotes and accepting when the right one i=
s reached. This is very slow when there are more than a dozen remote entrie=
s: about ~1 second per command.</div><div><br></div><div>Solution: Extend &=
quot;remote SKIP&quot; to take an optional parameter to skip &quot;n&quot; =
entries by one command.</div><div><br></div><div>Use of &quot;remote MOD&qu=
ot; is not useful here as it does not support change of protocol. It also h=
as some &quot;misbehaviour&quot; due to the way resolved addresses are cach=
ed.</div><div><br></div><div>(ii) remote-entry-get introduced here needs to=
 be extended to support requesting multiple or all remote entries in one co=
mmand.</div><div><br></div><div>Please ignore the current version. v3 is co=
ming.</div><div><br></div><div>Selva</div></div>
</blockquote></div>

--000000000000ae730005cd9e2f63--

