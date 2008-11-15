Message-ID: <491F4441.7080109@...1148...>
Date: Sat, 15 Nov 2008 22:50:57 +0100
From: Morten Christensen <mc-openvpn@...1148...>
MIME-Version: 1.0
References: <48F11865.5080903@...1135...>
In-Reply-To: <48F11865.5080903@...1135...>
Subject: Re: [Openvpn-devel] Alternative GUI for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Jochen Wierum <jochen@...1135...>
Cc: openvpn-devel@lists.sourceforge.net

Jochen Wierum skrev den 11-10-2008 23:19:
> Hi,
>
> My name is Jochen Wierum and I'm a student at a university of applied
> science in Germany. We work with OpenVPN there. Since a few weeks, we
> also have the option to use SmartCards instead of pkcs12 files.
>
> One problem was, that we have laptops which are used by many people with
> different SmartCards. But the OpenVPN GUI doesn't give the you
> opportunity to select which SmartCard to use. So I wrote an own small
> GUI for Windows in C#. It uses the Management Interface to control
> OpenVPN. It is very simple and not perfect. One Problem is that it
> requires administrator rights in Vista.
>
> It is written in C# 2008 and requires the .NET Framework 2.0. I released
> it under the GNU GPL v2.
>
> Perhaps someone thinks it is useful too.
>
> The source can be downloaded at:
> http://www.jowisoftware.de/openvpnmanager_src.zip
>
> The binarys are located at:
> http://www.jowisoftware.de/openvpnmanager.zip
>
>   
I have tried your GUI interface, but I use auth-user-pass in my config 
for authentification and your program only asks for the password and not 
the username.
( I have tried it, because I only want to enter the password, and tries 
to find a GUI, that can take the username from CN of the certificate, 
but completely omitting the username is not the solution in setup's like 
mine).

PS. The old/original gui changes color when it connects. That is a nice 
feature.

--
Morten Christensen








> Jochen
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>   


