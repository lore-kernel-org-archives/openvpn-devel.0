Message-ID: <454A6CE1.5070002@...41...>
Date: Thu, 02 Nov 2006 15:10:41 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <451FBC52.70900@...41...>	<451FC16A.2010906@...795...>	<45480C70.5080502@...41...>
	<200611011516.31060.alon.barlev@...277...>
In-Reply-To: <200611011516.31060.alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN Roadmap
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Alon Bar-Lev wrote:
> On Wednesday 01 November 2006 04:54, James Yonan wrote:
>   
>> OpenVPN 2.2 or 2.5
>> ------------------
>>
>> This release will be open to patches which extend OpenVPN
>> functionality without requiring a major rewrite of the core. 
>> Features that fit into these constraints include allowing the
>> OpenVPN server to listen on multiple TCP and UDP ports
>> simultaneously or improving/merging additional IPv6 functionality.
>>
>> There are a couple of useful new features already finished for
>> OpenVPN 2.2:
>>
>> * Added connection profiles feature.  See <connection>
>>   documentation in man page.
>>
>> * Added --disconnect-while-inactive feature.  See
>>   man page.
>>
>> Download via subversion:
>>
>>   svn co
>> https://svn.openvpn.net/projects/openvpn/branches/BETA22/openvpn
>>     
>
> What about:
>
> 1. Handling privilege dropping correctly, so that client can drop 
> privileges before connect.
>   

Actually there is flexibility here -- the client can drop privileges 
earlier by config file option, but it generally doesn't until after the 
connection is established so that it can accept pushed routes from the 
server -- we could fix this by using a split privilege model, but then 
you have to deal with the extra complexity.

> 2. Allow management interface to prompt for identity (out of several), 
> so that smartcard id can be chosen by the user. This will enable the 
> computer to have only one OpenVPN configuration file, and still suite 
> many users.
>
> 3. Allow the management to perform private key operations, so that 
> pre-authenticated keys can be used out of an agent, or different 
> sources, such as KDE, smartcards or any other storage. (This makes 2 
> obsolete).
>
> The will enable OpenVPN to be configured with the same settings for 
> every users and every computer in a workgroup, and allow the GUI to 
> prompt the user for the right credentials, remember user settings and 
> such.
>
> It is important to take the CryptoAPI and PKCS#11 out of the daemon, 
> since the daemon context will not always have access to smartcard 
> resources.
>
> So CryptoAPI and PKCS#11 code will be moved out of OpenVPN executable 
> into a library so that management application will be able to use 
> this functionality if they wish to, or replace it with different 
> implementation.
>
> The library will also implement regular PKCS#12 based identity, so 
> that the daemon will not have direct access to users' keys.
>
> As part of this, a simple management client console application will 
> be implemented, to allow users a quick startup.
>
> 4. On my TODO there is the certificate chain verification, and CRL 
> dynamic update... To allow multiple CAs and update CRL on request.
>
>   

I think it's great if you are volunteering to do this.   It's an 
interesting idea, to move CryptoAPI and PKCS#11 code out of OpenVPN 
executable into a library that would be used by the GUI.  My only 
concern is that I don't want to make it much more difficult to write an 
OpenVPN GUI.  So I'm thinking that this would be an optional capability 
that GUIs could choose to implement.


James


