Content-Type: multipart/alternative;
 boundary="------------LvM9XTyh1neBwbFSNk8ESny6"
Message-ID: <ae5ddbf4-44fd-4d4b-a045-53274aa9cc5d@...1823...>
Date: Fri, 10 Nov 2023 11:35:23 +0400
MIME-Version: 1.0
Content-Language: en-US, ru-RU
References: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
 <0acc8d93-6175-4d7e-a39a-269a9652ac3e@...1823...>
 <f2f54207-f37c-4c0d-96a3-a600cd2bb811@...1823...>
 <ZU3aVt0EgPyOQWEe@...1296...>
From: Dmitry Melekhov <dm@...1823...>
In-Reply-To: <ZU3aVt0EgPyOQWEe@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN 2.6.7 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------LvM9XTyh1neBwbFSNk8ESny6
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

10.11.2023 11:23, Gert Doering пишет:
> Hi,
>
> On Fri, Nov 10, 2023 at 11:19:58AM +0400, Dmitry Melekhov wrote:
>> OK, now I know what is broken.
>>
>> I have so called multihomed server,  and multihomed udp does not work in
>> 2.6.7.
>>
>> On server with only one external interface everything works OK.
> Are you using --multihome in your config?  If not, please add this - UDP
> on a server with multiple IP addresses of the same family (v4 or v6) can
> not work reliably without --multihome.

yes, sure.

as I said 2.6.6 works OK , and all previous versions since multihomed 
support for udp was introduced.

>
> If it does not work with --multihome, please send logs.


I see nothing strange in logs, server just lost connection, client too, 
then they reconnects.

> (There is one multihome-related code change in 2.6.6 -> 2.6.7, but that
> should only ever trigger if you use DCO)


I don't use dco, but multihomed udp does not work.


>
> gert
>
>

--------------LvM9XTyh1neBwbFSNk8ESny6
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">10.11.2023 11:23, Gert Doering пишет:<br>
    </div>
    <blockquote type="cite" cite="mid:ZU3aVt0EgPyOQWEe@...1296...">
      <pre class="moz-quote-pre" wrap="">Hi,

On Fri, Nov 10, 2023 at 11:19:58AM +0400, Dmitry Melekhov wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">OK, now I know what is broken.

I have so called multihomed server,  and multihomed udp does not work in
2.6.7.

On server with only one external interface everything works OK.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Are you using --multihome in your config?  If not, please add this - UDP
on a server with multiple IP addresses of the same family (v4 or v6) can
not work reliably without --multihome.</pre>
    </blockquote>
    <p>yes, sure.</p>
    <p>as I said 2.6.6 works OK , and all previous versions since
      multihomed support for udp was introduced.<br>
    </p>
    <blockquote type="cite" cite="mid:ZU3aVt0EgPyOQWEe@...1296...">
      <pre class="moz-quote-pre" wrap="">

If it does not work with --multihome, please send logs.
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>I see nothing strange in logs, server just lost connection,
      client too, then they reconnects.<br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:ZU3aVt0EgPyOQWEe@...1296...">
      <pre class="moz-quote-pre" wrap="">(There is one multihome-related code change in 2.6.6 -&gt; 2.6.7, but that
should only ever trigger if you use DCO)</pre>
    </blockquote>
    <p><br>
    </p>
    <p>I don't use dco, but multihomed udp does not work. <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:ZU3aVt0EgPyOQWEe@...1296...">
      <pre class="moz-quote-pre" wrap="">

gert


</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------LvM9XTyh1neBwbFSNk8ESny6--

