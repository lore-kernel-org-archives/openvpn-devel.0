Message-ID: <491CA5BD.1010809@...41...>
Date: Thu, 13 Nov 2008 15:10:05 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <4900B783.5090102@...1146...>
	<49018F8E.9080201@...1147...>	<49074664.9010307@...1146...>
	<49083955.80903@...1147...>	<49083C3C.3040401@...1146...>
	<49084017.7060306@...1147...> <49106CAE.2060902@...1146...>
In-Reply-To: <49106CAE.2060902@...1146...>
Subject: Re: [Openvpn-devel] [Openvpn-users] --auth-user-pass-verify and
	--script-security
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: ivars.strazdins@...1146...
Cc: Jan Just Keijser <janjust@...1147...>, Openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

>> this is a major gripe for me as well: the behaviour on how to start 
>> external programs changed quite drastically somewhere between rc7 and 
>> rc13 (I believe rc10 was the first version), especially on the Windows 
>> platform. Yet this is (as of today) poorly documented and nobody has 
>> written any info on how to convert old style scripts (e.g. 
>> "Auth4OpenVPN.vbs") to a new style ("cscript.exe ...." ) etc.
>> So, in short, your guess is as good as mine ... Personally I'd go for 
>> the second one.

> For those who still remembers what this threat was about - I managed to 
> get v2.1rc13 working with
> auth-user-pass-verify "c:/windows/system32/cscript.exe //H:cscript 
> c:/Progra~1/OpenVPN/config/Auth4OpenVPN.vbs" via-env
> fantastic!


I totally agree with you that we should not be breaking the semantics
for calling external programs, and it wasn't our intention to do so.
Our original hope was that the security benefits of migrating from
system() to execve() on unix and CreateProcess() on Windows could be
done transparently.  But seeing that that's not the case, I would
suggest that we offer the previous system() semantics as a deprecated
option, using the syntax

   script-security <level> <mode>

where mode is "execve" by default, (which means to use execve() on unix
family platforms or CreateProcess on Windows) or "system" which means to
use system().

This means that any OpenVPN config prior to 2.1_rc9 could continue to
use system() by adding:

   script-security 2 system

OpenVPN would issue a warning about system() usage being deprecated, but
would continue to use pre-2.1_rc9 external program calling semantics.

Comments?

James



