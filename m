Message-ID: <53BFA759.7060307@...1227...>
Date: Fri, 11 Jul 2014 10:59:05 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <53BF9998.5020906@...1921...> <53BFA5AA.4070305@...1147...>
In-Reply-To: <53BFA5AA.4070305@...1147...>
Content-Type: multipart/alternative;
	boundary="------------050401010807080809040109"
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
 configuration file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, Philipp Hagemeister <phihag@...1921...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050401010807080809040109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Am 11.07.14 10:51, schrieb Jan Just Keijser:
> On 11/07/14 10:00, Philipp Hagemeister wrote:
>> On modern systems, topology subnet should always be set, but it's
>> missing in the configuration file.
>> Add it with a short explanation.
> NACK
> There are a few annoying issues with
>   topology subnet
> esp when using server side things like
>   route <remote subnet> <mask>
>
> that will *fail* with 'topology subnet' ; until this is fixed this
> should NOT be considered the default.

I am confused here, route <remote subnet> <mask> would expand to

route <remote subnet> <mask> remote_gw in p2p, net30 and subnet toplogy.
And that should work in all topology modes. What am I missing here?

Arne

--------------050401010807080809040109
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Am 11.07.14 10:51, schrieb Jan Just
      Keijser:<br>
    </div>
    <blockquote cite="mid:53BFA5AA.4070305@...1147..." type="cite">
      <meta content="text/html; charset=ISO-8859-1"
        http-equiv="Content-Type">
      <div class="moz-cite-prefix">On 11/07/14 10:00, Philipp
        Hagemeister wrote:<br>
      </div>
      <blockquote cite="mid:53BF9998.5020906@...1921..." type="cite">
        <pre wrap="">On modern systems, topology subnet should always be set, but it's
missing in the configuration file.
Add it with a short explanation.
</pre>
      </blockquote>
      NACK<br>
      There are a few annoying issues with <br>
      &nbsp; topology subnet<br>
      esp when using server side things like<br>
      &nbsp; route &lt;remote subnet&gt; &lt;mask&gt;<br>
      <br>
      that will *fail* with 'topology subnet' ; until this is fixed this
      should NOT be considered the default.<br>
    </blockquote>
    <br>
    I am confused here, route &lt;remote subnet&gt; &lt;mask&gt; would
    expand to <br>
    <br>
    route &lt;remote subnet&gt; &lt;mask&gt; remote_gw in p2p, net30 and
    subnet toplogy. And that should work in all topology modes. What am
    I missing here?<br>
    <br>
    Arne<br>
  </body>
</html>

--------------050401010807080809040109--

