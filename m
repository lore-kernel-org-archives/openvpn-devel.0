MIME-Version: 1.0
Message-ID: <trinity-b2591293-0d7a-411f-9548-0e177be0f01c-1650832365276@...2672...>
From: Marc Becker <becm@...68...>
Date: Sun, 24 Apr 2022 22:32:45 +0200
In-Reply-To: <CAFHpkQFLyEdJwK+ewKAQst1KViTNuPf+EUjLvXX1=17xFj4rTg@...278...>
References: <20220424192510.75385-1-becm@...68...>
 <CAFHpkQFLyEdJwK+ewKAQst1KViTNuPf+EUjLvXX1=17xFj4rTg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] fix GitHub workflow working directories
 in MinGW builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

<html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><div>
<div>&gt;&quot;old&quot; links are immutable.</div>

<div>&nbsp;</div>
The &quot;old&quot; links also do not provide the latest versions (currently&nbsp;1.1.1n &amp; 3.0.2).</div>

<div>&nbsp;</div>

<div>While the mirrors do follow the logic of having only the latest version on top level,</div>

<div>it seams on the main site all versions can be fetched via this pattern (tested).</div>

<div>&nbsp;</div>

<div>This way building a matrix with [ 1.0.2, 1.1.1n, 3.0.2 ] should also be possible with little effort.</div>

<div>&nbsp;</div>

<div>It also does not require version&rarr;subpath magic for pre-3.0 versions (when OpenSSL introduced sane versioning).</div></div></body></html>

