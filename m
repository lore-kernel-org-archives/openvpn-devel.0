References: <99D61A626FDA8A4B90A270669121BE109921F37A@...2294...>
From: Gisle Vanem <gisle.vanem@...277...>
Message-ID: <8ae807ce-9e87-d4ca-e82f-d04847b611e6@...277...>
Date: Wed, 10 Oct 2018 13:00:01 +0200
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE109921F37A@...2294...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] MinGW to build DLL not EXE
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Simon Rozman wrote:

> I have almost finished integrating tapctl.exe and openvpnmsica.dll utilities
> for MSI packaging into the OpenVPN/openvpn repo. However, I am totally new
> with MinGW and would need some help.
> 
> How do you tell the OpenVPN's build process to create a DLL file, not an
> EXE?

Usually 'gcc -o file.dll -shared ...'.
What .dll are taking about, a plugin?

-- 
--gv

