Message-ID: <4B8A8401.3050500@...1227...>
Date: Sun, 28 Feb 2010 15:56:01 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <54cde1cd4bdc1e82da3cb67831cc45c0@...1228...>
	<4B8A6E08.3090204@...1114...>
In-Reply-To: <4B8A6E08.3090204@...1114...>
Subject: Re: [Openvpn-devel] OpenVPN Pf plugin/small status patch
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

  On 28.02.2010 14:22, David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 26/06/09 17:00, Arne Schwabe wrote:
>> Hi,
>>
>> I have written a simple plugin for packet filtering that looks up fw rules
>> in the order
>>
>> Commonname.pf
>> IP_Port.pf
>> IP.pf
>> default.pf
>>
>> If one of this files is found the file is used as PF configuration. Maybe
>> this plugin is useful for someone else.
> Hi!
>
> Thank you for your patches.  I've been looking at both patches, and I
> have some questions in regards to this plug-in.
>
> How does this packet filtering further work?  I do not completely
> understand how you imagine this should work.  I see that it tries to
> open a number of files with different filename criteria , and if it
> finds a file it copies it somewhere.
>
The packet filtering itself is already part of openvpn. It only works in 
tap mode iirc. See 
http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn/pf.c. A 
description of the packet filter format is given in 
http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn/management/management-notes.txt
COMMAND -- client-pf  (OpenVPN 2.1 or higher)

This plugin/patch only add the possibility to use the packet filter 
functionality without use of the management interface.

