Message-ID: <462C802F.6090007@...41...>
Date: Mon, 23 Apr 2007 03:45:19 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <462C562F.1050107@...41...>
	<002501c78574$e1322950$0201a8c0@...1010...>
In-Reply-To: <002501c78574$e1322950$0201a8c0@...1010...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc3 released
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
To: Serge Wautier <serge@...635...>
Cc: Openvpn-devel@lists.sourceforge.net

Serge Wautier wrote:
> Hi James,
>
>   
>> * The Windows Installer and TAP driver are now signed by
>>   OpenVPN Solutions LLC (in addition to the usual GnuPG
>>   signatures).
>>     
>
> What kind (purpose) of signature is this? Does this mean that Windows won't
> reject the driver anymore during installation?
>   

The signature on the installer .exe and drivers will cause Windows to 
pop up a dialog box before install that notes that the file was signed 
by OpenVPN Solutions, and asking if you want to proceed.  Unfortunately, 
this signature is not sufficient to pass Vista x64 driver signing 
enforcement.  On Vista x64, my understanding is that the TAP driver 
would need to be signed by Microsoft themselves.

James


