From: ValdikSS <valdikss@...277...>
References: <d0cc2a54-cd65-9ebd-1e6f-8d2b75bfb223@...277...>
	<CAKuzo_iam5RwR=grdc9cT8OL6AWdEp_bEh9jo1dhiyVf9T21sQ@...278...>
	<67275b0c-0491-b8e0-23d8-7ed548a6f3e3@...277...>
Message-ID: <16ad3121-4498-7a47-c481-f6e0c2b19084@...277...>
Date: Tue, 25 Apr 2017 23:40:17 +0300
MIME-Version: 1.0
In-Reply-To: <67275b0c-0491-b8e0-23d8-7ed548a6f3e3@...277...>
Content-Type: multipart/alternative;
	boundary="------------9DA6BB1F99A9A0C13AEBBD4A"
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Windows 10 Creators Update broke
 --block-outside-dns
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------9DA6BB1F99A9A0C13AEBBD4A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Please check updated version
https://github.com/ValdikSS/openvpn-with-patches/commit/80345eac823326299c5428a8db45dc06a8d10f7b

set_interface_metric() needs to be called from interactive service but the service doesn't include win32.h/c so I had to copy/paste code into it. How could this be improved?

On 18.04.2017 21:42, ValdikSS wrote:
> On 18.04.2017 21:37, Selva Nair wrote:
>>
>> On Sat, Apr 15, 2017 at 6:41 PM, ValdikSS <valdikss@...277... <mailto:valdikss@...277...>> wrote:
>>
>> How does this registry entry tell Windows that TAP adapter should be preferred for DNS? Or is this to be done in addition to setting up a preferred ordering of network adapters?
>
> It doesn't. I just remembered that option and set it. It worked for me when DNS is in the same subnet with user, but it fails if DNS is in the internet.
> Setting lower metric to the TAP interface correctly works in both cases, without reg patch.
>
>>
>> Can WFP be used to rewrite the source address? In that case we could just redirect all DNS requests through the TAP interface instead of dropping packets.
>
> Unfortunately not, not without kernel driver.
>
>> As for local ipv6 DNS servers, I do not think we should do anything about it unless the tunnel can handle v6 traffic.
>>
>> Selva
>
> I made a perliminary patch to set interface metric to 7:
> https://github.com/ValdikSS/openvpn-with-patches/commit/0651c0469038dd0ba39329f4b83ecd7e1d04323e
>
> This is static change for the interface. Currently this patch does not revert previous metric value if there were any or set it back to automatic. Should it be implemented in your opinion? It still won't revert this value back in case of OpenVPN crash or power outage. Yet I don't think that lower metric on TAP interface would have any influence for networking at all.
>
> Please tell your opinion guys. Selva said it should revert the previous value upon termination.
>


--------------9DA6BB1F99A9A0C13AEBBD4A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Please check updated version<br>
<a class="moz-txt-link-freetext" href="https://github.com/ValdikSS/openvpn-with-patches/commit/80345eac823326299c5428a8db45dc06a8d10f7b">https://github.com/ValdikSS/openvpn-with-patches/commit/80345eac823326299c5428a8db45dc06a8d10f7b</a><br>
    <br>
    <span class="blob-code-inner"><span class="pl-en">set_interface_metric()
        needs to be called from interactive service but the service
        doesn't include win32.h/c so I had to copy/paste code into it.
        How could this be improved?</span></span><br>
    <br>
    <div class="moz-cite-prefix">On 18.04.2017 21:42, ValdikSS wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:67275b0c-0491-b8e0-23d8-7ed548a6f3e3@...277...">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      On 18.04.2017 21:37, Selva Nair wrote:<br>
      <blockquote type="cite"
cite="mid:CAKuzo_iam5RwR=grdc9cT8OL6AWdEp_bEh9jo1dhiyVf9T21sQ@...278...">
        <div dir="ltr">
          <div class="gmail_extra"><br>
            <div class="gmail_quote">On Sat, Apr 15, 2017 at 6:41 PM,
              ValdikSS <span dir="ltr">&lt;<a
                  href="mailto:valdikss@...277..." target="_blank"
                  moz-do-not-send="true">valdikss@...277...</a>&gt;</span>
              wrote:<br>
            </div>
            <br>
            How does this registry entry tell Windows that TAP adapter
            should be preferred for DNS? Or is this to be done in
            addition to setting up a preferred ordering of network
            adapters?</div>
        </div>
      </blockquote>
      <br>
      It doesn't. I just remembered that option and set it. It worked
      for me when DNS is in the same subnet with user, but it fails if
      DNS is in the internet.<br>
      Setting lower metric to the TAP interface correctly works in both
      cases, without reg patch.<br>
      <br>
      <blockquote type="cite"
cite="mid:CAKuzo_iam5RwR=grdc9cT8OL6AWdEp_bEh9jo1dhiyVf9T21sQ@...278...">
        <div dir="ltr">
          <div class="gmail_extra"><br>
          </div>
          <div class="gmail_extra">Can WFP be used to rewrite the source
            address? In that case we could just redirect all DNS
            requests through the TAP interface instead of dropping
            packets.</div>
        </div>
      </blockquote>
      <br>
      Unfortunately not, not without kernel driver.<br>
      <br>
      <blockquote type="cite"
cite="mid:CAKuzo_iam5RwR=grdc9cT8OL6AWdEp_bEh9jo1dhiyVf9T21sQ@...278...">
        <div dir="ltr">
          <div class="gmail_extra"> As for local ipv6 DNS servers, I do
            not think we should do anything about it unless the tunnel
            can handle v6 traffic.</div>
          <div class="gmail_extra"><br>
          </div>
          <div class="gmail_extra">Selva</div>
        </div>
      </blockquote>
      <br>
      I made a perliminary patch to set interface metric to 7:<br>
      <a class="moz-txt-link-freetext"
href="https://github.com/ValdikSS/openvpn-with-patches/commit/0651c0469038dd0ba39329f4b83ecd7e1d04323e"
        moz-do-not-send="true">https://github.com/ValdikSS/openvpn-with-patches/commit/0651c0469038dd0ba39329f4b83ecd7e1d04323e</a><br>
      <br>
      This is static change for the interface. Currently this patch does
      not revert previous metric value if there were any or set it back
      to automatic. Should it be implemented in your opinion? It still
      won't revert this value back in case of OpenVPN crash or power
      outage. Yet I don't think that lower metric on TAP interface would
      have any influence for networking at all.<br>
      <br>
      Please tell your opinion guys. Selva said it should revert the
      previous value upon termination.<br>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------9DA6BB1F99A9A0C13AEBBD4A--

