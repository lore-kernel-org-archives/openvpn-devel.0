From: Arne Schwabe <arne@...1227...>
References: <5668A592.8080802@...2101...> <20151210083641.GZ24952@...1296...>
Message-ID: <566945DD.8050000@...1227...>
Date: Thu, 10 Dec 2015 10:29:01 +0100
MIME-Version: 1.0
In-Reply-To: <20151210083641.GZ24952@...1296...>
Subject: Re: [Openvpn-devel] MSVC "parser stack overflow"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Gisle Vanem <gvanem@...2101...>
Cc: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>



Am 10.12.15 um 09:36 schrieb Gert Doering:
> Hi,
>
> On Wed, Dec 09, 2015 at 11:05:06PM +0100, Gisle Vanem wrote:
>> While compiling src/openvpn/options.c with MSVC 2015, I got this
>> error:
>>   src/openvpn/options.c(5944): fatal error C1026: parser stack overflow, program too complex
>>
>> I've also seen such error in GeoIP-lib due to all the 'if..else if' statements.
>> Can this be written using some kind of a table-lookup code instead?
> We could, certainly, if we had nothing else to do.
>
> For the time being we just use a compiler that is not mainly a pain in the
> back, solidly stuck in the last century before C99 - as in, none of the
> core developers compile on windows, we all do cross-compilation with 
> mingw64 on Linux.
>
Or use the experimental Clang frontend for MSVC codegen

http://blogs.msdn.com/b/vcblog/archive/2015/12/04/introducing-clang-with-microsoft-codegen-in-vs-2015-update-1.aspx

As Gert said, that code is old, reliable and well tested. And just about
quirky enough that it is no straighforward table-lookup code conversion.

Arne


