References: <5668A592.8080802@...2101...>
	<20151210083641.GZ24952@...1296...> <56694CC9.6020103@...2101...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56694E7A.4010001@...1227...>
Date: Thu, 10 Dec 2015 11:05:46 +0100
MIME-Version: 1.0
In-Reply-To: <56694CC9.6020103@...2101...>
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
To: Gisle Vanem <gvanem@...2101...>, openvpn-devel@lists.sourceforge.net



Am 10.12.15 um 10:58 schrieb Gisle Vanem:
> Gert Doering wrote:
>
>> For the time being we just use a compiler that is not mainly a pain in the
>> back, solidly stuck in the last century before C99 - as in, none of the
>> core developers compile on windows, we all do cross-compilation with 
>> mingw64 on Linux.
> Well, MSVC 2015 is pretty up-to-date WRT C99. So I think you should remove
> all the *.vcxproj and msvc-*.bat files to prevent more people getting
> the impression you care about Windows.
>
Please note that we are an open source project and have thinly spread
resources. These files still work with older versions. Feel free to
submit patches that fix MSVC 2015 support.

Arne

