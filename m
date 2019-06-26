References: <CAFHpkQFOUB6hq4rQjCGLvbXprjvUL0aD3y107oYj15t6CSMxTg@...278...>
 <20190626063502.GS1097@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <9f92ae0a-cae6-39bd-932b-fa977686f27a@...1227...>
Date: Wed, 26 Jun 2019 14:05:01 +0200
MIME-Version: 1.0
In-Reply-To: <20190626063502.GS1097@...1296...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] how to migrate users to "no compression" config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 26.06.19 um 08:35 schrieb Gert Doering:
> Hi,
> 
> On Wed, Jun 26, 2019 at 01:48:34AM +0500, ???????? ?????????????? wrote:
>> 2) use push "compress empty" (if there's such an option) ?
> 
> you can do 
> 
>   push "compress"
> 
> with no arguments.  According to the docs, this will enable compression
> framing format, but no actual compression.
> 

Better use stub-v2 since that has no extra byte added and is also
compatible with clients that do not have a compress/comp-lzo directive.

(Unless you have packets that look like IPv5)

There is also a IV_STUB_V2=1 (or similar to detect if the client can do
this)

Arne

