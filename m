MIME-Version: 1.0
In-Reply-To: <1653841.mDJ7IUcjyx@...1526...>
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
	<8821332.jJMvSfGUe1@...1526...>
	<CAOazyz2gNp_wwXKYHtsZnFh_-ywXLqDkHd3n79X5VxGmv3=Cbg@...278...>
	<1653841.mDJ7IUcjyx@...1526...>
Date: Wed, 22 Feb 2012 12:37:59 +0200
Message-ID: <CAOazyz0xPKxbw-t5H_b39fTy8zVR_G=zhSo1PHy0gOE7Js1ARw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [build] Windows build test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Feb 22, 2012 at 12:36 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> On Wednesday 22 February 2012 10:32:23 Alon Bar-Lev wrote:
>> On Wed, Feb 22, 2012 at 12:27 PM, Heiko Hund <heiko.hund@...1489...> wrote:
>> > I was cross compiling for Windows previously doing something very
>> > standard
>> > like `./configure --host=i686-w64-mingw32 ...` followed by `make`. What
>> > the rationale behind moving away from this way?
>>
>> This is exactly what this build is doing.
>> Just it also builds the dependencies and package the output.
>> The most difficult task (usually) is to compile the dependencies.
>
> What dependencies do you mean? lzo, openssl and pkcs11-helper?

Right.
Look at the script.

