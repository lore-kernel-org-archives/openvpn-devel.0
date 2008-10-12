Message-ID: <48F1AE4F.3040305@...1135...>
Date: Sun, 12 Oct 2008 09:59:11 +0200
From: Jochen Wierum <jochen@...1135...>
MIME-Version: 1.0
References: <48F11865.5080903@...1135...>
	<9e0cf0bf0810111522nc8062afl7e727f9d871875ec@...278...>
In-Reply-To: <9e0cf0bf0810111522nc8062afl7e727f9d871875ec@...278...>
Subject: Re: [Openvpn-devel] Alternative GUI for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

The Problem is that I read STDIN and STDOUT of OpenVPN. To do this, I
have to run my Application at least with the same rights as OpenVPN.
OpenVPN has to run as admin to control the routes and the Tap-Device. So
my application has a problem.

If somebody knows a solution how to run a program as administrator and
read STDIN and STDOUT without having administrator rights he is welcome :-)

Jochen

Alon Bar-Lev wrote:
> Great!
> I was expected PKCS#11 enabled GUI for a long time!
> But why does it need administrative rights?
> 
> Alon.
> 
> On 10/11/08, Jochen Wierum <jochen@...1135...> wrote:
>> Hi,
>>
>>  My name is Jochen Wierum and I'm a student at a university of applied
>>  science in Germany. We work with OpenVPN there. Since a few weeks, we
>>  also have the option to use SmartCards instead of pkcs12 files.
>>
>>  One problem was, that we have laptops which are used by many people with
>>  different SmartCards. But the OpenVPN GUI doesn't give the you
>>  opportunity to select which SmartCard to use. So I wrote an own small
>>  GUI for Windows in C#. It uses the Management Interface to control
>>  OpenVPN. It is very simple and not perfect. One Problem is that it
>>  requires administrator rights in Vista.
>>
>>  It is written in C# 2008 and requires the .NET Framework 2.0. I released
>>  it under the GNU GPL v2.
>>
>>  Perhaps someone thinks it is useful too.
>>
>>  The source can be downloaded at:
>>  http://www.jowisoftware.de/openvpnmanager_src.zip
>>
>>  The binarys are located at:
>>  http://www.jowisoftware.de/openvpnmanager.zip
>>
>>  Jochen


