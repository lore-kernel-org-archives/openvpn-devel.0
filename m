References: <20170504173605.8269-1-valdikss@...277...>
	<CAKuzo_hKv+0LTi-pNh8xGMNTazgUjhXSkw2ZPGo0KDQ0SgsOHA@...278...>
From: ValdikSS <valdikss@...277...>
Message-ID: <9cc5162b-d81b-9286-e715-e6c7d807385d@...277...>
Date: Wed, 10 May 2017 19:08:27 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hKv+0LTi-pNh8xGMNTazgUjhXSkw2ZPGo0KDQ0SgsOHA@...278...>
Content-Type: multipart/alternative;
	boundary="------------96C8D10282057CD1BFE4F1AA"
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
--------------96C8D10282057CD1BFE4F1AA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 08.05.2017 17:47, Selva Nair wrote:
> Hi,
>
> Please bear with me for making a few more comments.

Please don't excuse. That's totally fine.

> This close to final so only
> a few minor issues.
>
> On Thu, May 4, 2017 at 1:36 PM, ValdikSS <valdikss@...277... <mailto:valdikss@...277...>> wrote:
>
> Nitpicking here, but anyway a new version is required (see below), so
> it would be nice if you wrap lines in commit message to something
> like about 70 to 80 at most. Not sure whether we have a policy on this..

Done.

>
>
> InitializeIpInterfaceEntry() is missing in all but very recent mingw32 versions
> (their commit logs show it was added in early 2015) so we may need
> to declare it in block_dns.c. I use Debian jessie (8.7) -- mingw gcc 4.9.1 and its
> not there. I believe Samuli's build system uses an even older version.

I don't know how to do that correctly. Can you please help me?

>
> Note that 64 bit build still succeeds with a warning but 32 bit will fail because
> of stdcall. Yes, its stdcall though MSDN doesn't mention it as such.
>
>
> This would be "Get" or "Return" not "Set"

Done.

>  
>
> ..
>
>  
>
> The current metric is queried and saved only for v4 while the metric is
> set and restored for both v4 and v6. Isn't it necessary to also save the
> metric for both independently? I'm not sure whether anyone really uses
> different metric for v4 and v6 but Windows allows it.

Done.

>  
>
> Here ">" should be ">=0", else automatic metric is not restored.

Done.

>  
>
> Finally there are some trailing white space errors (6 places). This is a good
> opportunity to fix those too.

Done.

Please check
https://github.com/ValdikSS/openvpn-with-patches/commit/02058c8f043d2731011222a05686478a09e479ec

Text vesion:
https://github.com/ValdikSS/openvpn-with-patches/commit/02058c8f043d2731011222a05686478a09e479ec.patch

>
> Thanks,
>
> Selva
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


--------------96C8D10282057CD1BFE4F1AA
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 08.05.2017 17:47, Selva Nair wrote:<br>
    <blockquote type="cite"
cite="mid:CAKuzo_hKv+0LTi-pNh8xGMNTazgUjhXSkw2ZPGo0KDQ0SgsOHA@...278...">
      <div dir="ltr">Hi,
        <div><br>
        </div>
        <div>Please bear with me for making a few more comments.</div>
      </div>
    </blockquote>
    <br>
    Please don't excuse. That's totally fine.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAKuzo_hKv+0LTi-pNh8xGMNTazgUjhXSkw2ZPGo0KDQ0SgsOHA@...278...">
      <div dir="ltr">
        <div> This close to final so only<br>
          a few minor issues.<br>
        </div>
        <div>
          <div class="gmail_extra"><br>
            <div class="gmail_quote">On Thu, May 4, 2017 at 1:36 PM,
              ValdikSS <span dir="ltr">&lt;<a
                  href="mailto:valdikss@...277..." target="_blank"
                  moz-do-not-send="true">valdikss@...277...</a>&gt;</span>
              wrote:
              <div><br>
              </div>
              <div>Nitpicking here, but anyway a new version is required
                (see below), so</div>
              <div>it would be nice if you wrap lines in commit message
                to something</div>
              <div>like about 70 to 80 at most. Not sure whether we have
                a policy on this..</div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Done.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAKuzo_hKv+0LTi-pNh8xGMNTazgUjhXSkw2ZPGo0KDQ0SgsOHA@...278...">
      <div dir="ltr">
        <div>
          <div class="gmail_extra">
            <div class="gmail_quote">
              <div><br>
              </div>
              <div><br>
              </div>
              <div>InitializeIpInterfaceEntry() is missing in all but
                very recent mingw32 versions<br>
              </div>
              <div>(their commit logs show it was added in early 2015)
                so we may need</div>
              <div>to declare it in block_dns.c. I use Debian jessie
                (8.7) -- mingw gcc 4.9.1 and its<br>
              </div>
              <div>not there. I believe Samuli's build system uses an
                even older version.</div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    I don't know how to do that correctly. Can you please help me?<br>
    <br>
    <blockquote type="cite"
cite="mid:CAKuzo_hKv+0LTi-pNh8xGMNTazgUjhXSkw2ZPGo0KDQ0SgsOHA@...278...">
      <div dir="ltr">
        <div>
          <div class="gmail_extra">
            <div class="gmail_quote">
              <div><br>
              </div>
              <div>Note that 64 bit build still succeeds with a warning
                but 32 bit will fail because</div>
              <div>of stdcall. Yes, its stdcall though MSDN doesn't
                mention it as such.<br>
              </div>
              <div><br>
              </div>
              <div><br>
              </div>
              <div>This would be "Get" or "Return" not "Set"</div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Done.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAKuzo_hKv+0LTi-pNh8xGMNTazgUjhXSkw2ZPGo0KDQ0SgsOHA@...278...">
      <div dir="ltr">
        <div>
          <div class="gmail_extra">
            <div class="gmail_quote">
              <div> </div>
              <div><br>
              </div>
              <div>..</div>
              <div><br>
              </div>
              <div> </div>
              <div><br>
              </div>
              <div>The current metric is queried and saved only for v4
                while the metric is</div>
              <div>set and restored for both v4 and v6. Isn't it
                necessary to also save the</div>
              <div>metric for both independently? I'm not sure whether
                anyone really uses<br>
                different metric for v4 and v6 but Windows allows it.<br>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Done.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAKuzo_hKv+0LTi-pNh8xGMNTazgUjhXSkw2ZPGo0KDQ0SgsOHA@...278...">
      <div dir="ltr">
        <div>
          <div class="gmail_extra">
            <div class="gmail_quote">
              <div> </div>
              <div><br>
              </div>
              <div>Here "&gt;" should be "&gt;=0", else automatic metric
                is not restored.</div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Done.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAKuzo_hKv+0LTi-pNh8xGMNTazgUjhXSkw2ZPGo0KDQ0SgsOHA@...278...">
      <div dir="ltr">
        <div>
          <div class="gmail_extra">
            <div class="gmail_quote">
              <div> </div>
              <div><br>
              </div>
              <div>Finally there are some trailing white space errors (6
                places). This is a good</div>
              <div>opportunity to fix those too.</div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Done.<br>
    <br>
    Please check<br>
<a class="moz-txt-link-freetext" href="https://github.com/ValdikSS/openvpn-with-patches/commit/02058c8f043d2731011222a05686478a09e479ec">https://github.com/ValdikSS/openvpn-with-patches/commit/02058c8f043d2731011222a05686478a09e479ec</a><br>
    <br>
    Text vesion:<br>
<a class="moz-txt-link-freetext" href="https://github.com/ValdikSS/openvpn-with-patches/commit/02058c8f043d2731011222a05686478a09e479ec.patch">https://github.com/ValdikSS/openvpn-with-patches/commit/02058c8f043d2731011222a05686478a09e479ec.patch</a><br>
    <br>
    <blockquote type="cite"
cite="mid:CAKuzo_hKv+0LTi-pNh8xGMNTazgUjhXSkw2ZPGo0KDQ0SgsOHA@...278...">
      <div dir="ltr">
        <div>
          <div class="gmail_extra">
            <div class="gmail_quote">
              <div><br>
              </div>
              <div>Thanks,</div>
              <div><br>
              </div>
              <div>Selva</div>
            </div>
          </div>
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

--------------96C8D10282057CD1BFE4F1AA--

