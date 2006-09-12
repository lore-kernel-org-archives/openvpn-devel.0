Message-ID: <450676EB.5080305@...177...>
Date: Tue, 12 Sep 2006 10:59:23 +0200
From: Farkas Levente <lfarkas@...177...>
MIME-Version: 1.0
References: <45066D08.9000402@...41...> <45067424.6020802@...177...>
	<45067546.2010702@...41...>
In-Reply-To: <45067546.2010702@...41...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.0.8 and 2.1_beta15
	released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>, 'openvpn-users' <openvpn-users@lists.sourceforge.net>

James Yonan wrote:
> Farkas Levente wrote:
>> James Yonan wrote:
>>   
>>> 2006.09.12 -- Version 2.0.8
>>>
>>> * Windows installer updated with OpenSSL 0.9.7k DLLs to fix
>>>   RSA Signature Forgery (CVE-2006-4339).
>>>
>>> * No changes to OpenVPN source code between 2.0.7 and 2.0.8.
>>>
>>> 2006.09.12 -- Version 2.1-beta15
>>>     
>>
>> hi,
>> is there any estimate/schedule/roadmap for 2.1 final?
>> yours.
>>
>>   
> We are basically there.  Beta15 has a number of changes and fixes that
> need to be tested.  I would like to see it out in the field for 30 to 60
> days before we promote it to final.

thanks.
the reason why i waiting for the final is not because we can't use beta
(actually all of our client and server are use the latest beta), but as
the topology is only in the beta series and other product as openvpn
gui, openvpn for pocket pc etc. are all based on the latest stable or
not follow the beta series. it'd be nice to reach the 2.1 final. in this
case all other upstream packager follow this step. (eg. currently we
can't use pda (pocket pc) to connect to our server which use topology)
or we should have to rebuild the pocket pc port which is not so trivial.

-- 
  Levente                               "Si vis pacem para bellum!"

