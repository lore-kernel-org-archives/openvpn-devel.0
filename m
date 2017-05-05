References: <20170504173605.8269-1-valdikss@...277...>
	<CAKuzo_i8Jnu2yRU8J9hpMkMpN5CZpEFCN-+OeSvicgxz0wn4tw@...278...>
From: ValdikSS <valdikss@...277...>
Message-ID: <e2f0ba41-3090-2d11-7789-82aa6b0e5b29@...277...>
Date: Sat, 6 May 2017 00:28:54 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i8Jnu2yRU8J9hpMkMpN5CZpEFCN-+OeSvicgxz0wn4tw@...278...>
Content-Type: multipart/alternative;
	boundary="------------FB9A2A6B333A0327171A32DF"
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Set a low interface metric for tap
 adapter when block-outside-dns is in use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------FB9A2A6B333A0327171A32DF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 05.05.2017 23:21, Selva Nair wrote:
> Hi,
>
> On Thu, May 4, 2017 at 1:36 PM, ValdikSS <valdikss@...277... <mailto:valdikss@...277...>> wrote:
>
> Hmm... If it starts with a random adapter, this metric lowering is not the right fix, isn't it? Or did you mean to say  "starting from lowest metric adapter"?
>  
>
> Well, I'm looking for to excuses to avoid the hard work of a careful review :)  If reducing metric is indeed the right approach in this cat and mouse game with MS, I'll try to look through this over the weekend.

From what I understand, Windows tries to use DNS in a round-robin fashion if adapter's metric is set to automatic, regardless of computed metric value. If we disable automatic metric on TAP adapter and set it lower than computed metric of other adapters, it would be used first.
I could be not completely correct with this, but I tested it and it works.

>
> Selva
>
>
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------FB9A2A6B333A0327171A32DF
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 05.05.2017 23:21, Selva Nair wrote:<br>
    <blockquote type="cite"
cite="mid:CAKuzo_i8Jnu2yRU8J9hpMkMpN5CZpEFCN-+OeSvicgxz0wn4tw@...278...">
      <div dir="ltr">
        <div class="gmail_extra">Hi,<br>
          <br>
        </div>
        <div class="gmail_extra">
          <div class="gmail_quote">On Thu, May 4, 2017 at 1:36 PM,
            ValdikSS <span dir="ltr">&lt;<a
                href="mailto:valdikss@...277..." target="_blank"
                moz-do-not-send="true">valdikss@...277...</a>&gt;</span>
            wrote:<br>
            <div><br>
            </div>
            <div>Hmm... If it starts with a random adapter, this metric
              lowering is not the right fix, isn't it? Or did you mean
              to say  "starting from lowest metric adapter"? <br>
               <br>
            </div>
            <div><br>
            </div>
            <div>Well, I'm looking for to excuses to avoid the hard work
              of a careful review :)  If reducing metric is indeed the
              right approach in this cat and mouse game with MS, I'll
              try to look through this over the weekend.<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    From what I understand, Windows tries to use DNS in a round-robin
    fashion if adapter's metric is set to automatic, regardless of
    computed metric value. If we disable automatic metric on TAP adapter
    and set it lower than computed metric of other adapters, it would be
    used first.<br>
    I could be not completely correct with this, but I tested it and it
    works.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAKuzo_i8Jnu2yRU8J9hpMkMpN5CZpEFCN-+OeSvicgxz0wn4tw@...278...">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">
            <div><br>
            </div>
            <div>Selva<br>
            </div>
          </div>
          <br>
          <br>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! <a class="moz-txt-link-freetext" href="http://sdm.link/slashdot">http://sdm.link/slashdot</a></pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------FB9A2A6B333A0327171A32DF--

