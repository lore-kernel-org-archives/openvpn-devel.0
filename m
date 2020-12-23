References: <20201220105430.GP976@...1296...>
 <093511bd-43c0-a37c-1d8f-335d9df451d6@...1227...>
 <20201220185402.GQ976@...1296...>
 <CAKuzo_ja=a9XxHkQX5Vv2_UTT1vWNfO8S-XLvvKZ_CQ6f-U1uQ@...278...>
 <20201221070420.GW976@...1296...>
 <CAKuzo_gMh+ZJ0YovjkUdyHzDO8cLsM_2Djsk_Hrx6N3AZMPw7w@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <65cbacc6-0c9f-4c46-04aa-6e707c7d5efd@...1147...>
Date: Wed, 23 Dec 2020 12:15:42 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gMh+ZJ0YovjkUdyHzDO8cLsM_2Djsk_Hrx6N3AZMPw7w@...278...>
Content-Type: multipart/alternative;
 boundary="------------5BD6EED22FEF36F593FB3410"
Content-Language: en-US
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------5BD6EED22FEF36F593FB3410
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

On 21/12/20 18:22, Selva Nair wrote:
>
>
> On Mon, Dec 21, 2020 at 2:04 AM Gert Doering <gert@...1296... 
> <mailto:gert@...1296...>> wrote:
>
>     Hi,
>
>     On Sun, Dec 20, 2020 at 07:31:42PM -0500, Selva Nair wrote:
>     > I thought we already went through this when we discussed the
>     proposed "echo
>     > msg" in considerable detail 3 years ago.
>
>     Yeah, sorry.  Seems I got distracted and forgot all about the
>     discussed
>     "solution space", and just remembered the itch.
>
>     I'm sure the thread is still sitting in my mailbox... will go
>     looking for
>     it today.
>
>
> For those who have lost the original threads:
>
> https://sourceforge.net/p/openvpn/mailman/openvpn-users/thread/CAEsd45T%2Bd6FUJ9Po0KHwtHjfuL9Q2D-poG8yFtY45Qyh%2BtHjkg%40mail.gmail.com/#msg36136236
>
> https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA%40mail.gmail.com/#msg36141193
>
> That was in Nov-Dec 2017. Actually, I was also thinking of reviving 
> this only the other day when intimating users about some updates 
> came up.. Somehow such itches re-surface at the end of the year :)
>
sorry to chip on so late, but at some point we did have a way to push 
env vars to the client (back in v2.2 at least):

inside a client-connect script you can/could do

echo "push \"setenv-safe MSG1 'hello'\"" > $1
echo "push \"setenv-safe MSG2 'download version 2.5 please'\"" >> $1

and then on the client-side you'd simply have to process them (as 
OPENVPN_MSG1 and OPENVPN_MSG2) - couldn't we reuse that to send messages 
to a connected client?

Sending messages to an unauthenticated client - other than "wrong 
password , go away" - seems dangerous to me.

JM2CW,

JJK



--------------5BD6EED22FEF36F593FB3410
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 21/12/20 18:22, Selva Nair wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAKuzo_gMh+ZJ0YovjkUdyHzDO8cLsM_2Djsk_Hrx6N3AZMPw7w@...278...">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Mon, Dec 21, 2020 at 2:04
            AM Gert Doering &lt;<a href="mailto:gert@...1296..."
              target="_blank" moz-do-not-send="true">gert@...1296...</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Hi,<br>
            <br>
            On Sun, Dec 20, 2020 at 07:31:42PM -0500, Selva Nair wrote:<br>
            &gt; I thought we already went through this when we
            discussed the proposed "echo<br>
            &gt; msg" in considerable detail 3 years ago.<br>
            <br>
            Yeah, sorry.  Seems I got distracted and forgot all about
            the discussed<br>
            "solution space", and just remembered the itch.<br>
            <br>
            I'm sure the thread is still sitting in my mailbox... will
            go looking for<br>
            it today.<br>
          </blockquote>
          <div><br>
          </div>
          <div>For those who have lost the original threads:</div>
          <div><br>
          </div>
          <div><a
href="https://sourceforge.net/p/openvpn/mailman/openvpn-users/thread/CAEsd45T%2Bd6FUJ9Po0KHwtHjfuL9Q2D-poG8yFtY45Qyh%2BtHjkg%40mail.gmail.com/#msg36136236"
              target="_blank" moz-do-not-send="true">https://sourceforge.net/p/openvpn/mailman/openvpn-users/thread/CAEsd45T%2Bd6FUJ9Po0KHwtHjfuL9Q2D-poG8yFtY45Qyh%2BtHjkg%40mail.gmail.com/#msg36136236</a></div>
          <div><br>
          </div>
          <div><a
href="https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA%40mail.gmail.com/#msg36141193"
              moz-do-not-send="true">https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA%40mail.gmail.com/#msg36141193</a></div>
          <div><br>
          </div>
          <div>That was in Nov-Dec 2017. Actually, I was also thinking
            of reviving this only the other day when intimating users
            about some updates came up.. Somehow such itches re-surface
            at the end of the year :)</div>
          <br>
        </div>
      </div>
    </blockquote>
    sorry to chip on so late, but at some point we did have a way to
    push env vars to the client (back in v2.2 at least):<br>
    <br>
    inside a client-connect script you can/could do<br>
    <br>
    echo "push \"setenv-safe MSG1 'hello'\"" &gt; $1<br>
    echo "push \"setenv-safe MSG2 'download version 2.5 please'\""
    &gt;&gt; $1<br>
    <br>
    and then on the client-side you'd simply have to process them (as
    OPENVPN_MSG1 and OPENVPN_MSG2) - couldn't we reuse that to send
    messages to a connected client?  <br>
    <br>
    Sending messages to an unauthenticated client - other than "wrong
    password , go away" - seems dangerous to me.<br>
    <br>
    JM2CW,<br>
    <br>
    JJK<br>
    <br>
    <br>
  </body>
</html>

--------------5BD6EED22FEF36F593FB3410--

