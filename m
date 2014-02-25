Message-ID: <530D0FE5.1050400@...1147...>
Date: Tue, 25 Feb 2014 22:49:25 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <5302AADC.80801@...277...>
	<20140218085500.GU16637@...1296...>	<530340C4.5060702@...277...>	<20140218115015.GW16637@...1296...>	<5304AFE4.2050702@...277...>
	<530917A4.4050905@...1528...>	<53093043.9080808@...277...>
	<5309B31C.50208@...1856...>	<530A9219.8050809@...277...>	<530BE62F.4090709@...1856...>
	<20140225082237.GN16637@...1296...>
	<CAA1AbxJAmvsPUQwiW7p4qP0fXMwwsiDjarp0nPjhwQj5d6PcPA@...278...>
In-Reply-To: <CAA1AbxJAmvsPUQwiW7p4qP0fXMwwsiDjarp0nPjhwQj5d6PcPA@...278...>
Content-Type: multipart/alternative;
	boundary="------------040905090101050101060307"
Subject: Re: [Openvpn-devel] [Patch] ECDH support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------040905090101050101060307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steffan,

On 25/02/14 09:48, Steffan Karger wrote:
> Hi,
>
> On Tue, Feb 25, 2014 at 9:22 AM, Gert Doering <gert@...1296... 
> <mailto:gert@...1296...>> wrote:
>
>     > Although there is apparently more work to do to get more cipher
>     suites
>     > working, this does give us a start on working with EC-crypto.
>     Maybe this
>     > part can go in (once ACK'ed) as 'the start of EC-support', so more
>     > people can help improve the code. Any other opinions on this?
>
>     - easy to understand and a bit more detailed README
>     - ACK from a "trusted contributor" (read: someone who has worked
>     on the
>       OpenVPN crypto code before and knows the pitfalls)
>
>     then I'm fine with it
>
>
> As for the README part, I can probably cook up something 'tonight' 
> (CEST). The ACK can obviously not come from me, but I'll try to make 
> the patch as easy as possible to review.
>
>     - PolarSSL...?
>
>
> ECDH and ECDSA will work upon upgrade to PolarSSL 1.3, for which I'll 
> send patches soon.
>

read up on the original ticket too:
   https://forums.openvpn.net/topic8404-30.html

there's some useful commands/description in there on how to generate 
ECDSA certificates.

HTH,

JJK


--------------040905090101050101060307
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Steffan,<br>
      <br>
      On 25/02/14 09:48, Steffan Karger wrote:<br>
    </div>
    <blockquote
cite="mid:CAA1AbxJAmvsPUQwiW7p4qP0fXMwwsiDjarp0nPjhwQj5d6PcPA@...278..."
      type="cite">
      <div dir="ltr">Hi,<br>
        <div>
          <div class="gmail_extra"><br>
            <div class="gmail_quote">On Tue, Feb 25, 2014 at 9:22 AM,
              Gert Doering <span dir="ltr">&lt;<a
                  moz-do-not-send="true"
                  href="mailto:gert@...1296..." target="_blank">gert@...1296...</a>&gt;</span>
              wrote:<br>
              <blockquote class="gmail_quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt;
                Although there is apparently more work to do to get more
                cipher suites<br>
                <div>
                  &gt; working, this does give us a start on working
                  with EC-crypto. Maybe this<br>
                  &gt; part can go in (once ACK'ed) as 'the start of
                  EC-support', so more<br>
                  &gt; people can help improve the code. Any other
                  opinions on this?<br>
                  <br>
                </div>
                - easy to understand and a bit more detailed README<br>
                - ACK from a "trusted contributor" (read: someone who
                has worked on the<br>
                &nbsp; OpenVPN crypto code before and knows the pitfalls)<br>
                <br>
                then I'm fine with it<br>
              </blockquote>
              <div><br>
              </div>
              <div>As for the README part, I can probably cook up
                something 'tonight' (CEST). The ACK can obviously not
                come from me, but I'll try to make the patch as easy as
                possible to review.<br>
              </div>
              <div><br>
              </div>
              <blockquote class="gmail_quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                - PolarSSL...?</blockquote>
              <div><br>
              </div>
              <div>ECDH and ECDSA will work upon upgrade to PolarSSL
                1.3, for which I'll send patches soon.<br>
                <br>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    read up on the original ticket too:<br>
    &nbsp; <a class="moz-txt-link-freetext" href="https://forums.openvpn.net/topic8404-30.html">https://forums.openvpn.net/topic8404-30.html</a><br>
    <br>
    there's some useful commands/description in there on how to generate
    ECDSA certificates.<br>
    <br>
    HTH,<br>
    <br>
    JJK<br>
    <br>
  </body>
</html>

--------------040905090101050101060307--

